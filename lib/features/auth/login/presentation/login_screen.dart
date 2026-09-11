import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_social_login_button_widget.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/auth/login/presentation/widget/dont_have_an_account_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validator_kit/validator_kit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late AnimationController _bottomSheetController;

  bool isChecked = false;
  bool isObscureText = true;
  bool isLoading = false;

  // Future<void> loginMethod() async {
  //   if (!formKey.currentState!.validate()) return;

  //   try {
  //     setState(() {
  //       isLoading = true;
  //     });

  //     final isSuccess = await loginRXObj.logInRX(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );

  //     if (isSuccess) {
  //       ToastUtil.showShortToast('Success Log In');
  //       NavigationService.navigateTo(Routes.navigationScreen);
  //     } else {
  //       // ToastUtil.showShortToast('Log In Failed');
  //     }
  //   } catch (e) {
  //     ToastUtil.showShortToast('Error: ${e.toString()}');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();

    _bottomSheetController = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    _bottomSheetController.dispose();

    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 48.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(40.h),
              Text('Welcome Back!', style: TextFontStyle.headlinePoppins60026),
              UIHelper.verticalSpace(6.h),
              Text(
                'Sign to your account building assurance',
                style: TextFontStyle.headlinePoppins50016.copyWith(
                  color: AppColors.grey500,
                ),
                textAlign: TextAlign.center,
              ),
              UIHelper.verticalSpace(48.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomSocialLoginButtonWidget(
                      image: AppIcons.googleLoginIcon,
                      onTap: () {},
                      text: 'Google',
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: CustomSocialLoginButtonWidget(
                      image: AppIcons.appleLoginIcon,
                      onTap: () {},
                      text: 'Apple',
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(12.h),
              Row(
                children: [
                  Expanded(
                    child: UIHelper.customDivider(
                      color: AppColors.grey200Color,
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  Text('Or', style: TextFontStyle.headlinePoppins50014),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: UIHelper.customDivider(
                      color: AppColors.grey200Color,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(24.h),
              Text('Email', style: TextFontStyle.headlinePoppins50016),
              UIHelper.verticalSpace(8.h),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email',
                borderColor: AppColors.primaryColor,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                prefixIcon: SvgPicture.asset(AppIcons.emailIcon),
                validator: ValidatorKit.combine([
                  ValidatorKit.required(),
                  ValidatorKit.email(),
                ]),
              ),
              UIHelper.verticalSpace(12.h),
              Text('Password', style: TextFontStyle.headlinePoppins50016),
              UIHelper.verticalSpace(8.h),
              CustomTextFormField(
                hintText: 'Password',
                controller: passwordController,
                obscureText: isObscureText,
                textInputAction: TextInputAction.done,
                prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                validator: ValidatorKit.combine([
                  ValidatorKit.required(),
                  ValidatorKit.password(),
                ]),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.grey400,
                  ),
                ),
              ),
              UIHelper.verticalSpace(24.h),
              isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: AppColors.textColor,
                        size: 60.h,
                      ),
                    )
                  : CustomButton(
                      onTap: () {
                        // loginMethod();
                      },
                      title: 'Sign in',
                    ),
              UIHelper.verticalSpace(16.h),
              GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.forgotPasswordScreen);
                },
                child: Center(
                  child: Text(
                    'Forgot password?',
                    style: TextFontStyle.headlinePoppins50016,
                  ),
                ),
              ),

              UIHelper.verticalSpace(24.h),
              DontHaveAccountWidget(
                signupOnTap: () {
                  NavigationService.navigateTo(Routes.signupScreen);
                },
              ),
              UIHelper.verticalSpace(16.h),
            ],
          ),
        ),
      ),
    );
  }
}
