import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validator_kit/validator_kit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isOldPasswordObscureText = true;
  bool isNewPasswordObscureText = true;
  bool isConfirmPasswordObscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Change Password',
        showLeadingIcon: true,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Old Password',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: oldPasswordController,
                  hintText: 'Old Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.password(),
                  ]),
                  obscureText: isOldPasswordObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isOldPasswordObscureText = !isOldPasswordObscureText;
                      });
                    },
                    child: Icon(
                      isOldPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grey400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  'New Password',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: newPasswordController,
                  hintText: 'New Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.password(),
                  ]),
                  obscureText: isNewPasswordObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isNewPasswordObscureText = !isNewPasswordObscureText;
                      });
                    },
                    child: Icon(
                      isNewPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grey400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  'Confirm New Password',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm New Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.confirmPassword(() {
                      return newPasswordController.text;
                    }),
                  ]),
                  obscureText: isConfirmPasswordObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordObscureText =
                            !isConfirmPasswordObscureText;
                      });
                    },
                    child: Icon(
                      isConfirmPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grey400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(24.h),
                isLoading
                    ? Center(
                        child: SpinKitCircle(
                          color: AppColors.buttonbgColor,
                          size: 60.h,
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          NavigationService.goBack;
                        },
                        title: 'Change',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
