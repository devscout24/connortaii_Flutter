import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: 'Settings'),
      body: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 12.w,
          right: 12.w,
          bottom: 80.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImages.settingsBgImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 22.h,
                      bottom: 22.h,
                      left: 12.w,
                    ),
                    child: Row(
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'name',
                                style: TextFontStyle.headlinePoppins60018
                                    .copyWith(color: AppColors.cFFFFFF),
                              ),
                              Text(
                                "Ready for your next inspection?",
                                style: TextFontStyle.headlinePoppins40014
                                    .copyWith(color: AppColors.cFFFFFF),
                                maxLines: 2,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(24.h),
            Text('Account', style: TextFontStyle.headlinePoppins60018),
            UIHelper.verticalSpace(12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey200Color,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.personIcon),

                            UIHelper.horizontalSpace(12.w),
                            Text(
                              'Profile',
                              style: TextFontStyle.headlinePoppins40016,
                            ),
                          ],
                        ),
                        SvgPicture.asset(AppIcons.arrowLeftIcon),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.passwordIcon),

                            UIHelper.horizontalSpace(12.w),
                            Text(
                              'Change Password',
                              style: TextFontStyle.headlinePoppins40016,
                            ),
                          ],
                        ),
                        SvgPicture.asset(AppIcons.arrowLeftIcon),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                  Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppIcons.personIcon),

                            UIHelper.horizontalSpace(12.w),
                            Text(
                              'Security',
                              style: TextFontStyle.headlinePoppins40016,
                            ),
                          ],
                        ),
                        SvgPicture.asset(AppIcons.arrowLeftIcon),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(6.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
