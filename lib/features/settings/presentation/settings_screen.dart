import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/settings/presentation/widgets/custom_logout_dialog.dart';
import 'package:connortaii_app/features/settings/presentation/widgets/profile_details_row_widget.dart';
import 'package:connortaii_app/features/settings/presentation/widgets/setting_items_row_widgets.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLoading = false;

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
            ProfileDetailsRowWidget(
              name: 'User Name',
              email: 'user@example.com',
              imageUrl:
                  'https://img.magnific.com/free-psd/3d-illustration-with-online-avatar_23-2151303097.jpg?semt=ais_hybrid&w=740&q=80',
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
                  SettingItemsRowWidget(
                    icon: AppIcons.profileIcon,
                    title: 'Profile',
                    onTap: () {
                      NavigationService.navigateTo(Routes.editProfileScreen);
                    },
                  ),
                  // SettingItemsRowWidget(
                  //   icon: AppIcons.changePasswordIcon,
                  //   title: 'Change Password',
                  //   onTap: () {
                  //     NavigationService.navigateTo(Routes.changePasswordScreen);
                  //   },
                  // ),
                  SettingItemsRowWidget(
                    icon: AppIcons.securityIcon,
                    title: 'Security',
                    onTap: () {
                      NavigationService.navigateTo(Routes.securityScreen);
                    },
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Text('About', style: TextFontStyle.headlinePoppins60018),
            UIHelper.verticalSpace(12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey200Color,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                children: [
                  SettingItemsRowWidget(
                    icon: AppIcons.privacyPolicyIcon,
                    title: 'Privacy Policy',
                    onTap: () {
                      NavigationService.navigateTo(Routes.privacyPolicyScreen);
                    },
                  ),
                  SettingItemsRowWidget(
                    icon: AppIcons.termsConditionIcon,
                    title: 'Terms & Conditions',
                    onTap: () {
                      NavigationService.navigateTo(Routes.termsConditionScreen);
                    },
                  ),
                ],
              ),
            ),
            UIHelper.verticalSpace(24.h),
            CustomIconButton(
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CustomLogoutDialogWidget(
                      title: 'Logging Out?',
                      subTitle: 'Are you sure you want to log out?',
                      cancelOnTap: () {
                        NavigationService.goBack;
                      },
                      confirmOnTap: () async {
                        setState(() {
                          isLoading = true;
                        });

                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(
                            child: SpinKitFadingCircle(
                              color: AppColors.c000000,
                              size: 60.0,
                            ),
                          ),
                        );

                        final value = await logOutRXOBJ.logOutRx();

                        setState(() {
                          isLoading = false;
                          appData.write(kKeyIsLoggedIn, false);
                          appData.write(kKeyAccessToken, null);
                          appData.write(kKeyFCMToken, null);
                        });

                        if (value) {
                          await appData.write(kKeyIsLoggedIn, false);
                          await appData.write(kKeyAccessToken, null);
                          await appData.write(kKeyFCMToken, null);

                          ToastUtil.showShortToast("Logout successfully.");
                          DioSingleton.instance.update("");

                          NavigationService.navigateToReplacementUntil(
                            Routes.loginScreen,
                          );
                        } else {
                          ToastUtil.showShortToast("Failed to logout.");
                        }
                      },
                      // confirmOnTap: () {
                      //   NavigationService.navigateTo(Routes.loginScreen);
                      // },
                    );
                  },
                );
              },
              title: 'Log Out',
              image: AppIcons.logoutIcon,
              fillColor: AppColors.grey300,
              textColor: AppColors.red,
            ),
          ],
        ),
      ),
    );
  }
}
