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
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validator_kit/validator_kit.dart';

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.grey200Color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.sp),
                child: Column(
                  children: [
                    _pickedImage != null
                        ? Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.grey200Color,
                                  borderRadius: BorderRadius.circular(32.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32.r),
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
                                borderRadius: BorderRadius.circular(32.r),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://img.magnific.com/free-psd/3d-illustration-with-online-avatar_23-2151303097.jpg?semt=ais_hybrid&w=740&q=80',
                                  height: 65.h,
                                  width: 65.w,
                                  placeholder: (context, url) =>
                                      Image.asset(AppImages.onboardingImage),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(AppImages.onboardingImage),
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
                    UIHelper.verticalSpace(16.h),
                    Text(
                      'Johnny Craft',
                      style: TextFontStyle.headlinePoppins50016,
                    ),
                  ],
                ),
              ),
            ),
            UIHelper.verticalSpace(12.h),
            UIHelper.verticalSpace(12.h),
            Text('First Name', style: TextFontStyle.headlinePoppins50016),
            UIHelper.verticalSpace(8.h),
            CustomTextFormField(
              controller: firstNameController,
              hintText: 'First Name',
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              suffixIcon: SvgPicture.asset(AppIcons.editNameIcon),
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
              suffixIcon: SvgPicture.asset(AppIcons.editNameIcon),
              validator: ValidatorKit.combine([
                ValidatorKit.required(),
                ValidatorKit.username(),
              ]),
            ),
            UIHelper.verticalSpace(24.h),
            CustomButton(
              onTap: () {
                NavigationService.goBack;
              },
              title: 'Save Changes',
            ),
          ],
        ),
      ),
    );
  }
}
