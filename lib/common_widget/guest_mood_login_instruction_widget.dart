import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GuestMoodLoginInstructionWidget extends StatelessWidget {
  final String title;
  const GuestMoodLoginInstructionWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: TextFontStyle.headlinePoppins60014.copyWith(
                color: AppColors.grey500,
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                // NavigationService.navigateTo(Routes.loginScreen);
              },
              child: Padding(
                padding: EdgeInsets.all(8.sp),
                child: Text('Login', style: TextFontStyle.headlinePoppins70016),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
