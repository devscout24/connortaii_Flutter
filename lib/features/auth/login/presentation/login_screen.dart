import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(40.h),
              Center(
                child: Text(
                  'Login',
                  style: TextFontStyle.headlinePoppins60024.copyWith(
                    color: AppColors.titleTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Center(
                child: Text(
                  'Welcome back! Log in to continue.',
                  style: TextFontStyle.headlinePoppins40016.copyWith(
                    color: AppColors.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(20.h),
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
              UIHelper.verticalSpace(16.h),
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
                    color: AppColors.grey300,
                  ),
                ),
              ),
              UIHelper.verticalSpace(16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateTo(Routes.forgotPasswordScreen);
                    },
                    child: Text(
                      'Forgot Password',
                      style: TextFontStyle.headlinePoppins40014,
                    ),
                  ),
                ],
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
                      title: 'Log in',
                    ),
              UIHelper.verticalSpace(16.h),
              DontHaveAccountWidget(
                signupOnTap: () {
                  NavigationService.navigateTo(Routes.signupScreen);
                },
              ),
              UIHelper.verticalSpace(16.h),

              Row(
                children: [
                  Expanded(
                    child: UIHelper.customDivider(color: AppColors.grey300),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    'Or',
                    style: TextFontStyle.headlinePoppins40014grey.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: UIHelper.customDivider(color: AppColors.grey300),
                  ),
                ],
              ),
              UIHelper.verticalSpace(8.h),
              GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(Routes.buyerNavigationScreen);
                },
                child: Text(
                  'Continue as Guest',
                  style: TextFontStyle.headlinePoppins40014grey.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
