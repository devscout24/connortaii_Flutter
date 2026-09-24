import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LevelButtonWidget extends StatelessWidget {
  final String label;
  final String iconSelected;
  final String iconUnselected;
  final Color color;
  final Color textColor;
  final bool selected;
  final VoidCallback onTap;

  const LevelButtonWidget({
    super.key,
    required this.label,
    required this.iconSelected,
    required this.iconUnselected,
    required this.color,
    required this.selected,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected ? color : AppColors.grey300,
            width: 2.w,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            selected
                ? SvgPicture.asset(iconUnselected)
                : SvgPicture.asset(iconSelected),
            UIHelper.verticalSpace(6.h),
            Text(
              label,
              style: selected
                  ? TextFontStyle.headlinePoppins50014.copyWith(
                      color: selected ? textColor : AppColors.cFFFFFF,
                    )
                  : TextFontStyle.headlinePoppins40014,
            ),
          ],
        ),
      ),
    );
  }
}
