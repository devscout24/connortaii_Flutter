import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: 52.h,
          left: 12.w,
          right: 12.w,
          bottom: 12.h,
        ),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32.r),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://img.magnific.com/free-psd/3d-illustration-with-online-avatar_23-2151303097.jpg?semt=ais_hybrid&w=740&q=80',
                    height: 56.h,
                    width: 56.w,
                    placeholder: (context, url) =>
                        Image.asset(AppImages.onboardingImage),
                    errorWidget: (context, url, error) =>
                        Image.asset(AppImages.onboardingImage),
                    fit: BoxFit.cover,
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'greetingsTitle 🌿',
                      style: TextFontStyle.headlinePoppins60012,
                    ),
                    Text(
                      "Let's find your plants!",
                      style: TextFontStyle.headlinePoppins80024.copyWith(
                        color: AppColors.titleTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
