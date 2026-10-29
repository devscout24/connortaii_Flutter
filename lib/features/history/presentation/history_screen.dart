import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/history/model/inspections_response_model.dart';
import 'package:connortaii_app/features/history/model/user_reports_response_model.dart';
import 'package:connortaii_app/features/history/presentation/widgets/history_completed_widget.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    getUserReportsRXObj.getUserReportsRX();
    getAllInspectionsRXObj.getAllInspectionsRX();
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      getUserReportsRXObj.getUserReportsRX(),
      getAllInspectionsRXObj.getAllInspectionsRX(),
    ]);
  }

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return '';
    try {
      final parsed = DateTime.parse(rawDate);
      return DateFormat('dd MMM yyyy').format(parsed);
    } catch (_) {
      return rawDate;
    }
  }

  Future<void> _handleDownload(String? pdfUrl) async {
    if (pdfUrl == null || pdfUrl.trim().isEmpty) {
      ToastUtil.showShortToast('Report PDF is not available yet');
      return;
    }
    final fullUrl = pdfUrl.startsWith('http') ? pdfUrl : '$url$pdfUrl';
    try {
      final uri = Uri.parse(fullUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        ToastUtil.showShortToast('Could not open report link');
      }
    } catch (e) {
      ToastUtil.showShortToast('Failed to open report link: $e');
    }
  }

  Future<void> _handleShare(String? pdfUrl, String title) async {
    if (pdfUrl == null || pdfUrl.trim().isEmpty) {
      ToastUtil.showShortToast('Report link is not available yet');
      return;
    }
    final fullUrl = pdfUrl.startsWith('http') ? pdfUrl : '$url$pdfUrl';
    try {
      await Clipboard.setData(ClipboardData(text: fullUrl));
      ToastUtil.showShortToast('Report link copied to clipboard');
    } catch (e) {
      ToastUtil.showShortToast('Failed to copy link: $e');
    }
  }

  Widget _buildEmptyState({
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.grey200Color,
          borderRadius: BorderRadius.circular(24.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey300,
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.all(12.sp),
              child: SvgPicture.asset(
                AppIcons.inspectionIcon,
                height: 36.h,
                width: 36.w,
              ),
            ),
            UIHelper.verticalSpace(16.h),
            Text(
              title,
              style: TextFontStyle.headlinePoppins60018,
              textAlign: TextAlign.center,
            ),
            UIHelper.verticalSpace(6.h),
            Text(
              subtitle,
              style: TextFontStyle.headlinePoppins40014.copyWith(
                color: AppColors.grey500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'History', showLeadingIcon: false),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: RefreshIndicator(
          onRefresh: _onRefresh,
          color: AppColors.c000000,
          child: StreamBuilder<UserReportsResponseModel>(
            stream: getUserReportsRXObj.dataFetcher,
            builder: (context, reportsSnapshot) {
              return StreamBuilder<InspectionsResponseModel>(
                stream: getAllInspectionsRXObj.dataFetcher,
                builder: (context, inspectionsSnapshot) {
                  final bool isWaiting =
                      (reportsSnapshot.connectionState ==
                              ConnectionState.waiting &&
                          reportsSnapshot.data?.data == null) &&
                      (inspectionsSnapshot.connectionState ==
                              ConnectionState.waiting &&
                          inspectionsSnapshot.data?.data == null);

                  if (isWaiting) {
                    return const Center(
                      child: SpinKitPulse(
                        color: AppColors.buttonbgColor,
                        size: 50.0,
                      ),
                    );
                  }

                  final reports = reportsSnapshot.data?.data ?? [];
                  final allInspections =
                      inspectionsSnapshot.data?.data ?? [];
                  final completedInspections = allInspections.where((item) {
                    final s = (item.status ?? '').toLowerCase().trim();
                    return s == 'completed';
                  }).toList();

                  final List<_HistoryReportItem> displayItems = [];
                  final Set<int> addedInspectionIds = {};

                  for (final r in reports) {
                    if (r.inspectionId != null) {
                      addedInspectionIds.add(r.inspectionId!);
                    }
                    final title = r.title?.trim().isNotEmpty == true
                        ? r.title!
                        : (r.address?.trim().isNotEmpty == true
                            ? r.address!
                            : 'Inspection Report #${r.id ?? (displayItems.length + 1)}');
                    final pdf = (r.pdfUrl?.trim().isNotEmpty == true)
                        ? r.pdfUrl
                        : r.downloadUrl;
                    displayItems.add(
                      _HistoryReportItem(
                        id: r.id,
                        title: title,
                        address: r.address ?? '',
                        date: _formatDate(r.date),
                        pdfUrl: pdf,
                      ),
                    );
                  }

                  for (final c in completedInspections) {
                    if (c.id != null && addedInspectionIds.contains(c.id)) {
                      continue;
                    }
                    final title = (c.propertyName?.trim().isNotEmpty == true)
                        ? c.propertyName!
                        : (c.propertyAddress?.trim().isNotEmpty == true
                            ? c.propertyAddress!
                            : 'Inspection #${c.id ?? (displayItems.length + 1)}');
                    final pdf = (c.pdfUrl?.trim().isNotEmpty == true)
                        ? c.pdfUrl
                        : c.reportUrl;
                    displayItems.add(
                      _HistoryReportItem(
                        id: c.id,
                        title: title,
                        address: c.propertyAddress ?? '',
                        date: _formatDate(c.inspectionDate),
                        pdfUrl: pdf,
                      ),
                    );
                  }

                  if (displayItems.isEmpty) {
                    return SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(top: 40.h),
                        child: _buildEmptyState(
                          title: 'No Completed Reports',
                          subtitle:
                              'Completed inspection reports will appear here.',
                        ),
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    itemCount: displayItems.length,
                    separatorBuilder: (context, index) =>
                        UIHelper.verticalSpace(14.h),
                    itemBuilder: (context, index) {
                      final item = displayItems[index];
                      return HistoryCompletedWidget(
                        title: item.title,
                        address: item.address,
                        date: item.date,
                        downloadInspectionOnTap: () =>
                            _handleDownload(item.pdfUrl),
                        shareInspectionOnTap: () =>
                            _handleShare(item.pdfUrl, item.title),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _HistoryReportItem {
  final int? id;
  final String title;
  final String address;
  final String date;
  final String? pdfUrl;

  _HistoryReportItem({
    this.id,
    required this.title,
    required this.address,
    required this.date,
    this.pdfUrl,
  });
}

