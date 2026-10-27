import 'dart:io';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class SignupImagePickerWidget extends StatelessWidget {
  const SignupImagePickerWidget({
    super.key,
    required XFile? pickedImage,
    this.onTap,
  }) : _pickedImage = pickedImage;

  final XFile? _pickedImage;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 120.w,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColors.grey200Color,
                borderRadius: BorderRadius.circular(100.r),
                border: Border.all(
                  color: AppColors.buttonbgColor.withValues(alpha: 0.15),
                  width: 2.w,
                ),
              ),
              child: _pickedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(100.r),
                      child: Image.file(
                        File(_pickedImage.path),
                        width: 120.w,
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      AppIcons.imagePickerIcon,
                      width: 120.w,
                      height: 120.h,
                    ),
            ),
            Positioned(
              bottom: 2.h,
              right: 2.w,
              child: Container(
                padding: EdgeInsets.all(8.sp),
                decoration: BoxDecoration(
                  color: AppColors.buttonbgColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.cFFFFFF,
                    width: 2.5.w,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.buttonbgColor.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  color: AppColors.cFFFFFF,
                  size: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
