import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartInspectionContainerWidget extends StatelessWidget {
  final VoidCallback onTap;
  const StartInspectionContainerWidget({super.key, required this.onTap});

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
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      UIHelper.verticalSpace(12.h),
                      Text(
                        "Start a new property inspection and generate a report.",
                        style: TextFontStyle.headlinePoppins40018grey.copyWith(
                          color: AppColors.grey800,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(AppImages.startInspectionIcon, height: 100.h),
              ],
            ),
            UIHelper.verticalSpace(8.h),
            CustomIconButton(
              onTap: onTap,
              title: "New Inspection",
              borderRadius: BorderRadius.circular(12.r),
              image: AppIcons.plusIcon,
            ),
          ],
        ),
      ),
    );
  }
}
