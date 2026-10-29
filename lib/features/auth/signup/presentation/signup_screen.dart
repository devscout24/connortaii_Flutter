import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/checkbox_row_widget.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/have_an_account_widget.dart';
import 'package:connortaii_app/features/auth/signup/presentation/widgets/signup_image_picker_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.request();
        if (status.isPermanentlyDenied) {
          if (mounted) {
            _showPermissionSettingsDialog('Camera');
          }
          return;
        } else if (!status.isGranted) {
          ToastUtil.showShortToast(
            'Camera permission is required to take photos',
          );
          return;
        }
      }

      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _pickedImage = pickedFile;
        });
      }
    } catch (e) {
      ToastUtil.showShortToast('Failed to pick image: $e');
    }
  }

  void _showPermissionSettingsDialog(String permissionName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$permissionName Permission Required'),
        content: Text(
          '$permissionName access is disabled. Please enable it in app settings to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  void _showImageSourceBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cFFFFFF,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey300,
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                UIHelper.verticalSpace(16.h),
                Text(
                  'Select Profile Photo',
                  style: TextFontStyle.headlinePoppins60020,
                ),
                UIHelper.verticalSpace(16.h),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: const BoxDecoration(
                      color: AppColors.grey200Color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      color: AppColors.buttonbgColor,
                    ),
                  ),
                  title: Text(
                    'Take Photo',
                    style: TextFontStyle.headlinePoppins50016,
                  ),
                  subtitle: Text(
                    'Use your camera to take a photo',
                    style: TextFontStyle.headlinePoppins40014grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                Divider(color: AppColors.grey200Color),
                ListTile(
                  leading: Container(
                    padding: EdgeInsets.all(8.sp),
                    decoration: const BoxDecoration(
                      color: AppColors.grey200Color,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: AppColors.buttonbgColor,
                    ),
                  ),
                  title: Text(
                    'Choose from Gallery',
                    style: TextFontStyle.headlinePoppins50016,
                  ),
                  subtitle: Text(
                    'Select an existing photo from storage',
                    style: TextFontStyle.headlinePoppins40014grey,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                UIHelper.verticalSpace(8.h),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isLoading = false;

  Future<bool> createProfileMethod() async {
    try {
      if (!isChecked) {
        ToastUtil.showShortToast(
          'Please accept the terms and conditions to sign up',
        );
        return false;
      }

      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        final result = await signupRxOBJ.signupRx(
          avatar: _pickedImage,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          password: passwordController.text,
          passwordConfirmation: confirmPasswordController.text,
          agreeToTerms: isChecked,
        );

        setState(() {
          isLoading = false;
        });

        if (result) {
          ToastUtil.showLongToast('Signup Successfully');
          NavigationService.navigateToWithArgs(Routes.signupVerifyScreen, {
            'email': emailController.text,
          });
        } else {
          // ToastUtil.showLongToast('Signup failed');
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ToastUtil.showShortToast(e.toString());
    }

    return true;
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
                UIHelper.verticalSpace(10.h),
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
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: CustomSocialLoginButtonWidget(
                //         image: AppIcons.googleLoginIcon,
                //         onTap: () {},
                //         text: 'Google',
                //       ),
                //     ),
                //     UIHelper.horizontalSpace(12.w),
                //     Expanded(
                //       child: CustomSocialLoginButtonWidget(
                //         image: AppIcons.appleLoginIcon,
                //         onTap: () {},
                //         text: 'Apple',
                //       ),
                //     ),
                //   ],
                // ),
                // UIHelper.verticalSpace(12.h),
                // Row(
                //   children: [
                //     Expanded(
                //       child: UIHelper.customDivider(
                //         color: AppColors.grey200Color,
                //       ),
                //     ),
                //     UIHelper.horizontalSpace(10.w),
                //     Text('Or', style: TextFontStyle.headlinePoppins50014),
                //     UIHelper.horizontalSpace(10.w),
                //     Expanded(
                //       child: UIHelper.customDivider(
                //         color: AppColors.grey200Color,
                //       ),
                //     ),
                //   ],
                // ),
                UIHelper.verticalSpace(24.h),
                SignupImagePickerWidget(
                  pickedImage: _pickedImage,
                  onTap: _showImageSourceBottomSheet,
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
                      color: AppColors.grey400,
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
                      color: AppColors.grey400,
                    ),
                  ),
                ),
                UIHelper.verticalSpace(14.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: AppColors.titleTextColor,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: const VisualDensity(
                        horizontal: -4,
                        vertical: -4,
                      ),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    UIHelper.horizontalSpace(2.w),
                    CheckboxRowWidget(
                      privacyOnTap: () {
                        NavigationService.navigateTo(Routes.privacyPolicyScreen);
                      },
                      termsOnTap: () {
                        NavigationService.navigateTo(Routes.termsConditionScreen);
                      },
                    ),
                  ],
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
                        onTap: isChecked
                            ? () {
                                createProfileMethod();
                              }
                            : () {
                                ToastUtil.showShortToast(
                                  'Please accept the terms and conditions to sign up',
                                );
                              },
                        title: 'Sign Up',
                        fillColor: isChecked
                            ? AppColors.c000000
                            : AppColors.grey300,
                        textColor: isChecked
                            ? AppColors.cFFFFFF
                            : AppColors.grey500,
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
