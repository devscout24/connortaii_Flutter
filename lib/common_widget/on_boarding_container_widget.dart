import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingContainerWidget extends StatelessWidget {
  final String? imagePath;
  final String text;
  final Color? backgroundColor;
  const OnBoardingContainerWidget({
    super.key,
    this.imagePath,
    required this.text,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor != null ? AppColors.cFFFFFF : AppColors.cE5B16F,
        borderRadius: BorderRadius.circular(80.r),
        border: Border.all(color: AppColors.cFFFFFF),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: // ...existing code...
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imagePath != null
                ? Row(
                    children: [
                      SvgPicture.asset(imagePath!),
                      UIHelper.horizontalSpace(4.w),
                    ],
                  )
                : const SizedBox.shrink(),
            Text(text, style: TextFontStyle.headlinePoppins60016),
          ],
        ),
      ),
    );
  }
}
