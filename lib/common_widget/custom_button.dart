import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.title,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              fillColor ?? AppColors.deepGreen,
              fillColor ?? AppColors.lightGreen,
            ],
          ),
          borderRadius: borderRadius ?? BorderRadius.circular(12.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 32.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextFontStyle.headlinePoppins60018.copyWith(
                  color: textColor ?? AppColors.cFFFFFF,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
