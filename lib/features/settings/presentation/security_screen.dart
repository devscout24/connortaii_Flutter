import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/settings/presentation/widgets/custom_delete_account_dialog.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Security',
        showLeadingIcon: true,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                NavigationService.navigateTo(Routes.changePasswordScreen);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.grey200Color,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.changePasswordIcon),
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
              ),
            ),
            UIHelper.verticalSpace(12.h),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return CustomDeleteAccountDialogWidget(
                      title: 'Delete Account?',
                      subTitle:
                          'This action is permanent and cannot be undone. You will lose all your data and access to your account.',
                      cancelOnTap: () {
                        NavigationService.goBack;
                      },
                      confirmOnTap: () {
                        NavigationService.navigateTo(Routes.signupScreen);
                      },
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.red.withAlpha(25),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.deleteAccountIcon),
                          UIHelper.horizontalSpace(12.w),
                          Text(
                            'Delete Account',
                            style: TextFontStyle.headlinePoppins40016.copyWith(
                              color: AppColors.red,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        AppIcons.arrowLeftIcon,
                        color: AppColors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
