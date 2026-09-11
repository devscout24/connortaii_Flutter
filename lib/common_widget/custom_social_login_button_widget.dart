import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSocialLoginButtonWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;

  const CustomSocialLoginButtonWidget({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey200Color,
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(18.sp),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              UIHelper.horizontalSpace(8.w),
              Text(text, style: TextFontStyle.headlinePoppins50016),
            ],
          ),
        ),
      ),
    );
  }
}
