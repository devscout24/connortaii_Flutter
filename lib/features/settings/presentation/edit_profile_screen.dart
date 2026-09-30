import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/assets_helper/app_image.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late final ImagePicker _imagePicker;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _pickedImage = pickedFile;
      });
    }
  }

  bool isLoading = false;
  bool hasInitialized = false;

  Future<void> editProfile() async {
    if (!formKey.currentState!.validate()) return;

    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }

      await editProfileRxOBJ.editProfileRx(
        avatar: _pickedImage != null ? XFile(_pickedImage!.path) : null,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        // dateOfBirth: dobController.text,
      );

      ToastUtil.showLongToast('Profile Updated');
      getProfileRXObj.getProfileRX();
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      NavigationService.goBack;
    } catch (error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      ToastUtil.showShortToast("Error Profile: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: 'Profile',
        showLeadingIcon: true,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: StreamBuilder(
              stream: getProfileRXObj.dataFetcher,
              builder: (context, snapshot) {
                final data = snapshot.data?.data;

                if (!hasInitialized && data != null) {
                  firstNameController.text = data.firstName ?? '';
                  lastNameController.text = data.lastName ?? '';
                  hasInitialized = true;
                }

                if (snapshot.connectionState == ConnectionState.waiting &&
                    data == null) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: const Center(
                      child: SpinKitPulse(
                        color: AppColors.buttonbgColor,
                        size: 70.0,
                      ),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return const Center(child: Text(""));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.grey200Color,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(36.sp),
                        child: Column(
                          children: [
                            _pickedImage != null
                                ? Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.grey200Color,
                                          borderRadius: BorderRadius.circular(
                                            32.r,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            32.r,
                                          ),
                                          child: Image.file(
                                            File(_pickedImage!.path),
                                            width: 65.w,
                                            height: 65.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        right: -5,
                                        child: GestureDetector(
                                          onTap: _pickImageFromGallery,
                                          child: SvgPicture.asset(
                                            AppIcons.editPhotoIcon,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          32.r,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: data?.avatar ?? '',
                                          height: 65.h,
                                          width: 65.w,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                                AppImages.onboardingImage,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                                AppImages.onboardingImage,
                                              ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -5,
                                        right: -5,
                                        child: GestureDetector(
                                          onTap: _pickImageFromGallery,
                                          child: SvgPicture.asset(
                                            AppIcons.editPhotoIcon,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ),
                    UIHelper.verticalSpace(12.h),
                    UIHelper.verticalSpace(12.h),
                    Text(
                      'First Name',
                      style: TextFontStyle.headlinePoppins50016,
                    ),
                    UIHelper.verticalSpace(8.h),
                    CustomTextFormField(
                      controller: firstNameController,
                      hintText: 'First Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      suffixIcon: SvgPicture.asset(AppIcons.editNameIcon),
                    ),
                    UIHelper.verticalSpace(12.h),
                    Text(
                      'Last Name',
                      style: TextFontStyle.headlinePoppins50016,
                    ),
                    UIHelper.verticalSpace(8.h),
                    CustomTextFormField(
                      controller: lastNameController,
                      hintText: 'Last Name',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      suffixIcon: SvgPicture.asset(AppIcons.editNameIcon),
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
                              editProfile();
                            },
                            title: 'Save Changes',
                          ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
