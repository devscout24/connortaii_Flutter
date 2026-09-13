import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentInspectionWidget extends StatelessWidget {
  final String title;
  final String status;
  final String address;
  final String date;
  final String sectionCompleteValue;
  final VoidCallback onTap;
  const RecentInspectionWidget({
    super.key,
    required this.title,
    required this.status,
    required this.address,
    required this.date,
    required this.sectionCompleteValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextFontStyle.headlinePoppins50016),
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
                      status,
                      style: TextFontStyle.headlinePoppins50016,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  address,
                  style: TextFontStyle.headlinePoppins40014.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
                UIHelper.horizontalSpace(8.w),
                CircleAvatar(radius: 4.r, backgroundColor: AppColors.grey500),
                UIHelper.horizontalSpace(8.w),
                Text(
                  date,
                  style: TextFontStyle.headlinePoppins40014.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(16.h),
            UIHelper.customDivider(),
            UIHelper.verticalSpace(16.h),
            Text(
              "$sectionCompleteValue / 10 Sections Complete",
              style: TextFontStyle.headlinePoppins50016,
            ),
            UIHelper.verticalSpace(6.h),
            LinearProgressIndicator(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.c000000,
              value: double.parse(sectionCompleteValue) / 10,
              minHeight: 5.h,
            ),
            UIHelper.verticalSpace(20.h),
            CustomIconButton(
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
    );
  }
}
