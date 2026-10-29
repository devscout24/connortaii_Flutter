import 'dart:async';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportGeneratedScreen extends StatefulWidget {
  final String? pdfUrl;
  final String? title;
  final String? address;
  final int? inspectionId;

  const ReportGeneratedScreen({
    super.key,
    this.pdfUrl,
    this.title,
    this.address,
    this.inspectionId,
  });

  @override
  State<ReportGeneratedScreen> createState() => _ReportGeneratedScreenState();
}

class _ReportGeneratedScreenState extends State<ReportGeneratedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool _isGenerating = true;
  bool _hasError = false;
  String _errorMessage = '';
  String? _pdfUrl;

  @override
  void initState() {
    super.initState();
    _pdfUrl = widget.pdfUrl;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _progressAnimation = Tween<double>(begin: 0.08, end: 0.90).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeOutCubic,
      ),
    );

    if (_pdfUrl != null && _pdfUrl!.trim().isNotEmpty) {
      _isGenerating = false;
    } else {
      _isGenerating = true;
      _progressController.forward();
      _startReportGeneration();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  Future<void> _startReportGeneration() async {
    setState(() {
      _isGenerating = true;
      _hasError = false;
      _errorMessage = '';
    });
    _progressController.reset();
    _progressController.forward();

    final id = widget.inspectionId ?? appData.read<int>(kKeyInspectionID);
    if (id == null) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Inspection ID not found';
      });
      return;
    }

    try {
      final response = await generateReportRxObj.generateReportRx(
        inspectionId: id,
      );

      if (response != null) {
        String? pdf;
        final data = response['data'];
        if (data is Map) {
          pdf = (data['pdf_url'] ??
                  data['download_url'] ??
                  data['report_url'] ??
                  data['url'])
              ?.toString();
        } else if (response['pdf_url'] != null) {
          pdf = response['pdf_url'].toString();
        }

        // Complete the progress animation
        await _progressController.animateTo(
          1.0,
          duration: const Duration(milliseconds: 400),
        );
        await Future.delayed(const Duration(milliseconds: 250));

        // Clear stored active inspection id
        await appData.remove(kKeyInspectionID);

        // Refresh home and history
        getHomeInspectionsRXObj.getHomeInspectionsRX();
        getAllInspectionsRXObj.getAllInspectionsRX();
        getUserReportsRXObj.getUserReportsRX();

        if (mounted) {
          setState(() {
            _pdfUrl = pdf;
            _isGenerating = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _hasError = true;
            _errorMessage = generateReportRxObj.lastErrorMessage ??
                'Could not generate report. Please try again or check server.';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = generateReportRxObj.lastErrorMessage ?? e.toString();
        });
      }
    }
  }

  Future<void> _handleDownload() async {
    final pdfUrl = _pdfUrl;
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

  Future<void> _handleShare() async {
    final pdfUrl = _pdfUrl;
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

  Widget _buildGeneratingView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.verticalSpace(36.h),
        Text(
          'Generating Report...',
          style: TextFontStyle.headlinePoppins60020,
        ),
        UIHelper.verticalSpace(14.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _hasError ? 0.0 : _progressAnimation.value,
                minHeight: 8.h,
                backgroundColor: AppColors.grey300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.c000000,
                ),
              );
            },
          ),
        ),
        UIHelper.verticalSpace(10.h),
        Center(
          child: Text(
            _hasError ? _errorMessage : 'This may take few seconds',
            style: TextFontStyle.headlinePoppins40012.copyWith(
              color: _hasError ? AppColors.red : AppColors.grey500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (_hasError) ...[
          UIHelper.verticalSpace(24.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => NavigationService.goBack,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(color: AppColors.grey300),
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        style: TextFontStyle.headlinePoppins50016
                            .copyWith(color: AppColors.c000000),
                      ),
                    ),
                  ),
                ),
              ),
              UIHelper.horizontalSpace(12.w),
              Expanded(
                child: GestureDetector(
                  onTap: _startReportGeneration,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.c000000,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Center(
                      child: Text(
                        'Retry',
                        style: TextFontStyle.headlinePoppins50016
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildGeneratedView(String fileName) {
    return Column(
      children: [
        UIHelper.verticalSpace(28.h),
        Center(
          child: Text(
            'Report Generated',
            style: TextFontStyle.headlinePoppins60020,
            textAlign: TextAlign.center,
          ),
        ),
        UIHelper.verticalSpace(20.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey200Color,
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(AppIcons.pdfIcon),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: Text(
                      fileName,
                      style: TextFontStyle.headlinePoppins50016,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              GestureDetector(
                onTap: _handleDownload,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.c000000,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(AppIcons.downloadPdfIcon),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        'Download pdf',
                        style: TextFontStyle.headlinePoppins50016
                            .copyWith(color: AppColors.cFFFFFF),
                      ),
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(10.h),
              GestureDetector(
                onTap: _handleShare,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.cFFFFFF,
                    borderRadius: BorderRadius.circular(40.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppIcons.shareIcon,
                        colorFilter: const ColorFilter.mode(
                          AppColors.c000000,
                          BlendMode.srcIn,
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Text(
                        'Share',
                        style: TextFontStyle.headlinePoppins50016
                            .copyWith(color: AppColors.c000000),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            NavigationService.navigateToReplacementUntil(
              Routes.navigationScreen,
            );
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 14.h),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: AppColors.grey300),
            ),
            child: Center(
              child: Text(
                'Back to home',
                style: TextFontStyle.headlinePoppins50016
                    .copyWith(color: AppColors.c000000),
              ),
            ),
          ),
        ),
        UIHelper.verticalSpace(24.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String fileName;
    if (widget.title != null &&
        widget.title!.trim().isNotEmpty &&
        !widget.title!.trim().startsWith('Inspection #')) {
      fileName = widget.title!.trim().endsWith('.pdf')
          ? widget.title!.trim()
          : '${widget.title!.trim()}.pdf';
    } else {
      fileName = 'Report.pdf';
    }

    return PopScope(
      canPop: _hasError,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (!_isGenerating) {
          NavigationService.navigateToReplacementUntil(
            Routes.navigationScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.cFFFFFF,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                UIHelper.verticalSpace(60.h),
                Center(
                  child: Image.asset(
                    AppIcons.reportGenerateIcon,
                    width: 220.w,
                    fit: BoxFit.contain,
                  ),
                ),
                if (_isGenerating)
                  _buildGeneratingView()
                else
                  Expanded(child: _buildGeneratedView(fileName)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
