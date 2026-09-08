import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackSkipButton extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onSkipTap;

  const CustomBackSkipButton({
    super.key,
    required this.onTap,
    required this.onSkipTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: onTap,
          // child: SvgPicture.asset(AppIcons.homeIcon),
        ),
        GestureDetector(
          onTap: onSkipTap,
          child: Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
                side: const BorderSide(),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              child: Text('Skip', style: TextFontStyle.headlinePoppins60016),
            ),
          ),
        ),
      ],
    );
  }
}
