import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_social_login_button_widget.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/checkbox_row_widget.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/have_an_account_widget.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/signup_image_picker_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validator_kit/validator_kit.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isObscureText = true;
  bool isConfirmPasswordObscureText = true;

  final ImagePicker _picker = ImagePicker();
  XFile? _pickedImage;

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 48.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create an account',
                  style: TextFontStyle.headlinePoppins60026,
                ),
                UIHelper.verticalSpace(2.h),
                Text(
                  'Sign up to your account building assurance',
                  style: TextFontStyle.headlinePoppins50016.copyWith(
                    color: AppColors.grey500,
                  ),
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
                GestureDetector(
                  onTap: pickImageFromGallery,
                  child: SignupImagePickerWidget(pickedImage: _pickedImage),
                ),
                UIHelper.verticalSpace(12.h),
                Text('First Name', style: TextFontStyle.headlinePoppins50016),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: firstNameController,
                  hintText: 'First Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.personIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.username(),
                  ]),
                ),
                UIHelper.verticalSpace(12.h),
                Text('Last Name', style: TextFontStyle.headlinePoppins50016),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: lastNameController,
                  hintText: 'Last Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.personIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.username(),
                  ]),
                ),
                UIHelper.verticalSpace(12.h),
                Text('Email', style: TextFontStyle.headlinePoppins50016),
                UIHelper.verticalSpace(8.h),
                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email',
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
                  controller: passwordController,
                  hintText: 'Password',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  prefixIcon: SvgPicture.asset(AppIcons.passwordIcon),
                  validator: ValidatorKit.combine([
                    ValidatorKit.required(),
                    ValidatorKit.password(),
                  ]),
                  obscureText: isObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.grey600,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(12.h),
                Text(
                  'Confirm Password',
                  style: TextFontStyle.headlinePoppins50016,
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
                      color: AppColors.grey600,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(16.h),

                CustomButton(
                  onTap: () {
                    NavigationService.navigateToWithArgs(
                      Routes.signupVerifyScreen,
                      {'email': emailController.text},
                    );
                  },
                  title: 'Sign Up',
                ),
                UIHelper.verticalSpace(8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Checkbox(
                    //   value: isChecked,
                    //   activeColor: AppColors.titleTextColor,
                    //   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    //   visualDensity: const VisualDensity(
                    //     horizontal: -4,
                    //     vertical: -4,
                    //   ),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       isChecked = value!;
                    //     });
                    //   },
                    // ),
                    // UIHelper.horizontalSpace(2.w),
                    CheckboxRowWidget(
                      privacyOnTap: () {
                        // NavigationService.navigateTo(Routes.privacyPolicyScreen);
                      },
                      termsOnTap: () {},
                    ),
                  ],
                ),
                UIHelper.verticalSpace(24.h),
                HaveAnAccountWidget(
                  loginOnTap: () {
                    NavigationService.navigateTo(Routes.loginScreen);
                  },
                ),
                UIHelper.verticalSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
