import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLogoutDialogWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? cancelOnTap;
  final void Function()? confirmOnTap;
  const CustomLogoutDialogWidget({
    super.key,
    required this.title,
    required this.subTitle,
    this.cancelOnTap,
    this.confirmOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: AppColors.cFFFFFF,
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextFontStyle.headlinePoppins70024.copyWith(
                color: AppColors.grey800,
              ),
            ),
            UIHelper.verticalSpace(4.h),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              style: TextFontStyle.headlinePoppins40016.copyWith(
                color: AppColors.fontGreyColor,
              ),
            ),
            UIHelper.verticalSpace(24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: cancelOnTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.grey200Color,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 12.h,
                        ),
                        child: Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headlinePoppins60016.copyWith(
                            color: AppColors.fontGreyColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: confirmOnTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.red.withAlpha(25),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 12.h,
                        ),
                        child: Text(
                          'Logout',
                          textAlign: TextAlign.center,
                          style: TextFontStyle.headlinePoppins60016.copyWith(
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
