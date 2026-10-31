import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final BorderRadius? borderRadius;
  final Color? fillColor;
  final Color? textColor;
  final Color? borderColor;
  final String image;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.title,
    this.borderRadius,
    this.fillColor,
    this.textColor,
    this.borderColor,
    required this.image,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: fillColor ?? AppColors.c000000,
          borderRadius: borderRadius ?? BorderRadius.circular(50.r),
          border: Border.all(color: borderColor ?? Colors.transparent),
        ),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(image),
              UIHelper.horizontalSpace(8.w),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textStyle ??
                        TextFontStyle.headlinePoppins60016.copyWith(
                          color: textColor ?? AppColors.cFFFFFF,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
