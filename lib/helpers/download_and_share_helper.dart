import 'dart:io';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final class DownloadAndShareHelper {
  DownloadAndShareHelper._();

  /// Formats and ensures a full URL for the report PDF.
  static String getFullPdfUrl(String? pdfUrl) {
    if (pdfUrl == null || pdfUrl.trim().isEmpty) return '';
    final trimmed = pdfUrl.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    return '$url$trimmed';
  }

  /// Downloads the PDF file directly to the device and opens it.
  static Future<void> downloadAndOpenPdf({
    required BuildContext context,
    required String? pdfUrl,
    required String title,
  }) async {
    final fullUrl = getFullPdfUrl(pdfUrl);
    if (fullUrl.isEmpty) {
      ToastUtil.showShortToast('Report PDF is not available yet');
      return;
    }

    // Show loading spinner dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinKitCircle(color: AppColors.c000000, size: 50.sp),
              UIHelper.verticalSpace(14.h),
              Text(
                'Downloading report...',
                style: TextFontStyle.headlinePoppins50014,
              ),
            ],
          ),
        ),
      ),
    );

    try {
      Directory dir;
      if (Platform.isAndroid) {
        dir = (await getExternalStorageDirectory()) ??
            (await getApplicationDocumentsDirectory());
      } else {
        dir = await getApplicationDocumentsDirectory();
      }

      final sanitizedTitle = title
          .replaceAll(RegExp(r'[^\w\s\.-]'), '_')
          .trim()
          .replaceAll(' ', '_');
      final fileName = sanitizedTitle.endsWith('.pdf')
          ? sanitizedTitle
          : '${sanitizedTitle.isNotEmpty ? sanitizedTitle : 'Inspection_Report'}.pdf';

      final savePath = '${dir.path}/$fileName';

      await Dio().download(
        fullUrl,
        savePath,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      // Dismiss dialog
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      ToastUtil.showShortToast('Report downloaded to device');

      // Open the downloaded file
      final openResult = await OpenFilex.open(savePath);
      if (openResult.type != ResultType.done) {
        // Fallback to launching URL if native viewer fails
        final uri = Uri.parse(fullUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      // Dismiss dialog
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }

      // Fallback: try opening with system browser
      try {
        final uri = Uri.parse(fullUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          ToastUtil.showShortToast('Failed to download report: $e');
        }
      } catch (_) {
        ToastUtil.showShortToast('Failed to download report: $e');
      }
    }
  }

  /// Shows share bottom sheet with options to:
  /// 1. Share via apps (WhatsApp, Telegram, Messages, AirDrop, etc.)
  /// 2. Copy report link to clipboard
  static void showShareOptions({
    required BuildContext context,
    required String? pdfUrl,
    required String title,
  }) {
    final fullUrl = getFullPdfUrl(pdfUrl);
    if (fullUrl.isEmpty) {
      ToastUtil.showShortToast('Report link is not available yet');
      return;
    }

    final reportTitle =
        title.trim().isNotEmpty ? title.trim() : 'Inspection Report';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.cFFFFFF,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 32.h),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 44.w,
                    height: 5.h,
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
                UIHelper.verticalSpace(18.h),
                Text(
                  'Share Report',
                  style: TextFontStyle.headlinePoppins60020,
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  'Share the report link with others or copy to clipboard',
                  style: TextFontStyle.headlinePoppins40014grey,
                ),
                UIHelper.verticalSpace(16.h),
                // URL Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.grey200Color,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.grey300),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppIcons.pdfIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                      UIHelper.horizontalSpace(10.w),
                      Expanded(
                        child: Text(
                          fullUrl,
                          style: TextFontStyle.headlinePoppins40012.copyWith(
                            color: AppColors.textColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                // Share via Apps (WhatsApp, Telegram, AirDrop, etc.)
                GestureDetector(
                  onTap: () async {
                    Navigator.of(bottomSheetContext).pop();
                    final box = context.findRenderObject() as RenderBox?;
                    final origin = box != null
                        ? box.localToGlobal(Offset.zero) & box.size
                        : null;

                    await Share.share(
                      'Here is the inspection report for $reportTitle: $fullUrl',
                      subject: '$reportTitle - Inspection Report',
                      sharePositionOrigin: origin,
                    );
                  },
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
                        SvgPicture.asset(
                          AppIcons.shareIcon,
                          colorFilter: const ColorFilter.mode(
                            AppColors.cFFFFFF,
                            BlendMode.srcIn,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          'Share via Apps (WhatsApp, Telegram...)',
                          style: TextFontStyle.headlinePoppins60014
                              .copyWith(color: AppColors.cFFFFFF),
                        ),
                      ],
                    ),
                  ),
                ),
                UIHelper.verticalSpace(10.h),
                // Copy Link option
                GestureDetector(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: fullUrl));
                    if (bottomSheetContext.mounted) {
                      Navigator.of(bottomSheetContext).pop();
                    }
                    ToastUtil.showShortToast('Report link copied to clipboard!');
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(40.r),
                      border: Border.all(color: AppColors.grey300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.copy_rounded,
                          size: 18,
                          color: AppColors.c000000,
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Text(
                          'Copy Link',
                          style: TextFontStyle.headlinePoppins60014
                              .copyWith(color: AppColors.c000000),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

