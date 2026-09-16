import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_back_button.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validator_kit/validator_kit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
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
                    'Forgot Password?',
                    style: TextFontStyle.headlinePoppins60026,
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(8.h),
                Center(
                  child: Text(
                    "Dont’t worry! it happens. Please enter the address associated with your account",
                    style: TextFontStyle.headlinePoppins50016.copyWith(
                      color: AppColors.grey500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                UIHelper.verticalSpace(32.h),
                Text(
                  'Email',
                  style: TextFontStyle.headlinePoppins50016,
                  textAlign: TextAlign.start,
                ),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.email(),
                  ]),
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
                          NavigationService.navigateToWithArgs(
                            Routes.forgotPasswordVerifyScreen,
                            {'email': emailController.text},
                          );
                          // forgotEmailMethod();
                        },
                        title: 'Get OTP',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
