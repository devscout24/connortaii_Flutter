import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_back_button.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validator_kit/validator_kit.dart';

class ForgotUpdatePasswordScreen extends StatefulWidget {
  final String email;

  const ForgotUpdatePasswordScreen({super.key, required this.email});

  @override
  State<ForgotUpdatePasswordScreen> createState() =>
      _ForgotUpdatePasswordScreenState();
}

class _ForgotUpdatePasswordScreenState
    extends State<ForgotUpdatePasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isPasswordChecked = false;
  bool isPasswordObscureText = true;
  bool isConfirmPasswordChecked = false;
  bool isConfirmPasswordObscureText = true;
  bool isLoading = false;

  Future<void> changePasswordMethod() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        final success = await forgotPasswordChangeRxOBJ.forgotPasswordChangeRx(
          email: widget.email,
          newPassword: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          resetToken: appData.read(kKeyotpVerifyToken),
        );
        if (success) {
          setState(() {
            isLoading = false;
          });
          NavigationService.navigateTo(Routes.loginScreen);
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (error) {
        setState(() {
          isLoading = false;
        });
        ToastUtil.showShortToast("Reset password failed: ${error.toString()}");
      }
    } else {
      ToastUtil.showShortToast("Invalid form data");
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 52.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UIHelper.verticalSpace(6.h),
                CustomBackButton(
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
                UIHelper.verticalSpace(4.h),
                Center(child: Image.asset(AppImages.passwordImage)),
                UIHelper.verticalSpace(40.h),
                Center(
                  child: Text(
                    'Create New Password',
                    style: TextFontStyle.headlinePoppins60026,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Center(
                  child: Text(
                    "Your new password must be different from previously used passwords",
                    style: TextFontStyle.headlinePoppins50016.copyWith(
                      color: AppColors.grey500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(20.h),
                Text(
                  'Password',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.password(),
                  ]),
                  obscureText: isPasswordObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordObscureText = !isPasswordObscureText;
                      });
                    },
                    child: Icon(
                      isPasswordObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.grey400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  'Confirm Password',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.confirmPassword(() {
                      return passwordController.text;
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
                          color: AppColors.c000000,
                          size: 60.h,
                        ),
                      )
                    : CustomButton(
                        onTap: () {
                          changePasswordMethod();
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
