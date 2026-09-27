import 'dart:io';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SignupImagePickerWidget extends StatelessWidget {
  const SignupImagePickerWidget({super.key, required XFile? pickedImage})
    : _pickedImage = pickedImage;

  final XFile? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _pickedImage != null
            ? Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey200Color,
                    // border: Border.all(color: AppColors.primaryColor, width: 1.w),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Image.file(
                      File(_pickedImage.path),
                      width: 120.w,
                      height: 120.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            : Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey200Color,
                    borderRadius: BorderRadius.circular(100.r),
                    // border: Border.all(color: AppColors.primaryColor, width: 1.w),
                  ),
                  child: Image.asset(
                    AppIcons.imagePickerIcon,
                    width: 120.w,
                    height: 120.h,

                    // color: AppColors.primaryColor,
                  ),
                ),
              ),
        // UIHelper.verticalSpace(4.h),
        // Center(
        //   child: Text(
        //     'Choose Photo',
        //     style: TextFontStyle.headlinePoppins40016grey.copyWith(
        //       color: AppColors.buttonbgColor,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
