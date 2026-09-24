import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildReasonChipWidget extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final VoidCallback onTap;
  const BuildReasonChipWidget({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.c000000 : AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Text(
          reason,
          style: isSelected
              ? TextFontStyle.headlinePoppins50014.copyWith(
                  color: AppColors.cFFFFFF,
                )
              : TextFontStyle.headlinePoppins40014,
        ),
      ),
    );
  }
}
