import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoInspectionWidget extends StatelessWidget {
  const NoInspectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey300,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.sp),
                    child: SvgPicture.asset(
                      AppIcons.inspectionIcon,
                      height: 36.h,
                      width: 36.w,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  "No inspections yet",
                  style: TextFontStyle.headlinePoppins60018,
                ),
                UIHelper.verticalSpace(4.h),
                Text(
                  "Your completed inspections will appear here.",
                  style: TextFontStyle.headlinePoppins40016.copyWith(
                    color: AppColors.grey500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
