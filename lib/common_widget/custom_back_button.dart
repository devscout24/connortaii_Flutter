import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onTap;

  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey50,
              borderRadius: BorderRadius.circular(52.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: SvgPicture.asset(AppIcons.backIcon),
            ),
          ),
        ),
      ],
    );
  }
}
