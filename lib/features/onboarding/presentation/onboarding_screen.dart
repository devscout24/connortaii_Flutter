import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 52.h),
        child: Column(
          children: [
            Spacer(),
            Image.asset(AppImages.onboardingImage),
            Spacer(),
            Text(
              'Welcome to Property Inspection',
              style: TextFontStyle.headlinePoppins60024,
            ),
            UIHelper.verticalSpace(2.h),
            Text(
              'Professional property inspections at your fingertip',
              style: TextFontStyle.headlinePoppins40014,
            ),
            UIHelper.verticalSpace(52.h),
            CustomButton(
              onTap: () {
                NavigationService.navigateTo(Routes.signupScreen);
              },
              title: 'Get Started',
            ),
            UIHelper.verticalSpace(12.h),
            CustomButton(
              onTap: () {
                NavigationService.navigateTo(Routes.loginScreen);
              },
              title: 'Login Account',
              fillColor: AppColors.grey200Color,
              textColor: AppColors.c000000,
              borderColor: AppColors.grey300,
            ),
          ],
        ),
      ),
    );
  }
}
