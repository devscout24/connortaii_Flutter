import 'dart:ui';

import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildAccessibilityButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final bool isRestrictedButton;
  final VoidCallback onTap;
  const BuildAccessibilityButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.isRestrictedButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          height: 54.h,
          decoration: BoxDecoration(
            color: isSelected
                ? (isRestrictedButton ? AppColors.red : AppColors.cFFFFFF)
                : AppColors.cFFFFFF,
            borderRadius: BorderRadius.circular(52.r),
            border: Border.all(
              color: isSelected && isRestrictedButton
                  ? AppColors.red500
                  : AppColors.grey300,
            ),
          ),
          child: Text(
            title,
            style: isSelected && isRestrictedButton
                ? TextFontStyle.headlinePoppins60016.copyWith(
                    color: AppColors.cFFFFFF,
                  )
                : TextFontStyle.headlinePoppins40014,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
