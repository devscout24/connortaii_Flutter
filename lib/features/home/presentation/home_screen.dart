import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/home/model/home_inspections_response_model.dart';
import 'package:connortaii_app/features/home/presentation/widgets/no_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/recent_inspection_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/starts_inspection_container_widget.dart';
import 'package:connortaii_app/features/home/presentation/widgets/top_user_info_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _openingInspectionId;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    getHomeInspectionsRXObj.getHomeInspectionsRX();
    getProfileRXObj.getProfileRX();
  }

  Future<void> _onRefresh() async {
    await Future.wait([
      getHomeInspectionsRXObj.getHomeInspectionsRX(),
      getProfileRXObj.getProfileRX(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: AppColors.c000000,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: 52.h,
              left: 12.w,
              right: 12.w,
              bottom: 24.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<HomeInspectionsResponseModel>(
                  stream: getHomeInspectionsRXObj.dataFetcher,
                  builder: (context, homeSnapshot) {
                    final homeUser = homeSnapshot.data?.data?.user;

                    return StreamBuilder(
                      stream: getProfileRXObj.dataFetcher,
                      builder: (context, profileSnapshot) {
                        final profileUser = profileSnapshot.data?.data;

                        final name = (homeUser?.name?.trim().isNotEmpty == true)
                            ? homeUser!.name!
                            : (profileUser != null
                                ? '${profileUser.firstName ?? ''} ${profileUser.lastName ?? ''}'.trim()
                                : '');
                        final avatar = homeUser?.avatar ?? profileUser?.avatar ?? '';

                        if (homeSnapshot.connectionState ==
                                ConnectionState.waiting &&
                            homeSnapshot.data?.data == null &&
                            profileSnapshot.data?.data == null) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: const Center(
                              child: SpinKitPulse(
                                color: AppColors.buttonbgColor,
                                size: 50.0,
                              ),
                            ),
                          );
                        }

                        return TopUserInfoWidget(
                          imageUrl: avatar,
                          name: name,
                        );
                      },
                    );
                  },
                ),
                UIHelper.verticalSpace(22.h),
                StartInspectionContainerWidget(
                  onTap: () async {
                    if (_openingInspectionId != null) return;
                    await appData.write(kKeyInspectionID, null);
                    await NavigationService.navigateTo(
                      Routes.newInspectionScreen,
                    );
                    _fetchData();
                  },
                ),
                UIHelper.verticalSpace(22.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Inspections',
                      style: TextFontStyle.headlinePoppins50018,
                    ),
                  ],
                ),
                UIHelper.verticalSpace(12.h),
                StreamBuilder<HomeInspectionsResponseModel>(
                  stream: getHomeInspectionsRXObj.dataFetcher,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        snapshot.data?.data == null) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Center(
                          child: SpinKitPulse(
                            color: AppColors.buttonbgColor,
                            size: 50.0,
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasError && snapshot.data?.data == null) {
                      return const NoInspectionWidget();
                    }

                    final inspections =
                        snapshot.data?.data?.recentInspections ?? [];

                    if (inspections.isEmpty) {
                      return const NoInspectionWidget();
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: inspections.length,
                      separatorBuilder: (context, index) =>
                          UIHelper.verticalSpace(14.h),
                      itemBuilder: (context, index) {
                        final item = inspections[index];
                        final title =
                            (item.propertyName?.trim().isNotEmpty == true)
                                ? item.propertyName!
                                : (item.propertyAddress?.trim().isNotEmpty == true
                                    ? item.propertyAddress!
                                    : 'Inspection #${item.id ?? (index + 1)}');
                        final address = item.propertyAddress ?? '';
                        final date = _formatDate(item.inspectionDate);

                        return RecentInspectionWidget(
                          title: title,
                          status: item.status ?? 'in_progress',
                          address: address,
                          date: date,
                          sectionCompleteValue: '${item.completedSections ?? 0}',
                          totalSections: item.totalSections ?? 10,
                          isLoading: _openingInspectionId == item.id,
                          onTap: () async {
                            if (_openingInspectionId != null) return;
                            setState(() {
                              _openingInspectionId = item.id;
                            });
                            try {
                              if (item.id != null) {
                                await appData.write(kKeyInspectionID, item.id);
                              }
                              await NavigationService.navigateToWithArgs(
                                Routes.newInspectionScreen,
                                {'title': title},
                              );
                              _fetchData();
                            } finally {
                              if (mounted) {
                                setState(() {
                                  _openingInspectionId = null;
                                });
                              }
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
