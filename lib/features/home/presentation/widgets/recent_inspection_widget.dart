import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentInspectionWidget extends StatelessWidget {
  final String title;
  final String status;
  final String address;
  final String date;
  final String sectionCompleteValue;
  final int totalSections;
  final VoidCallback onTap;
  final bool isLoading;

  const RecentInspectionWidget({
    super.key,
    required this.title,
    required this.status,
    required this.address,
    required this.date,
    required this.sectionCompleteValue,
    this.totalSections = 10,
    required this.onTap,
    this.isLoading = false,
  });

  String _formatStatus(String raw) {
    if (raw.isEmpty) return 'In Progress';
    final formatted = raw.replaceAll('_', ' ');
    return formatted
        .split(' ')
        .map((w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final completed = int.tryParse(sectionCompleteValue) ?? 0;
    final total = totalSections > 0 ? totalSections : 10;
    final progress = (completed / total).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey200Color,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextFontStyle.headlinePoppins50016,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey300,
                      borderRadius: BorderRadius.circular(21.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      child: Text(
                        _formatStatus(status),
                        style: TextFontStyle.headlinePoppins50016,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(4.h),
              Row(
                children: [
                  if (address.isNotEmpty) ...[
                    Flexible(
                      child: Text(
                        address,
                        style: TextFontStyle.headlinePoppins40014.copyWith(
                          color: AppColors.grey500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    CircleAvatar(radius: 4.r, backgroundColor: AppColors.grey500),
                    UIHelper.horizontalSpace(8.w),
                  ],
                  Text(
                    date,
                    style: TextFontStyle.headlinePoppins40014.copyWith(
                      color: AppColors.grey500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              UIHelper.verticalSpace(16.h),
              UIHelper.customDivider(),
              UIHelper.verticalSpace(16.h),
              Text(
                "$completed / $total Sections Complete",
                style: TextFontStyle.headlinePoppins50016,
              ),
              UIHelper.verticalSpace(6.h),
              LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.c000000,
                value: progress,
                minHeight: 5.h,
              ),
              UIHelper.verticalSpace(20.h),
              isLoading
                  ? Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: AppColors.grey300,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: AppColors.c000000,
                              size: 22.sp,
                            ),
                            UIHelper.horizontalSpace(10.w),
                            Text(
                              "Loading Inspection...",
                              style: TextFontStyle.headlinePoppins50014.copyWith(
                                color: AppColors.c000000,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : CustomIconButton(
                      onTap: onTap,
                      title: "Continue Inspection",
                      borderRadius: BorderRadius.circular(12.r),
                      image: AppIcons.inspectionIcon,
                      fillColor: AppColors.grey300,
                      textColor: AppColors.c000000,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
