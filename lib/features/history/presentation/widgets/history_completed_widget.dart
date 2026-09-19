import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HistoryCompletedWidget extends StatelessWidget {
  final String title;
  final String address;
  final String date;
  final VoidCallback downloadInspectionOnTap;
  final VoidCallback shareInspectionOnTap;

  const HistoryCompletedWidget({
    super.key,
    required this.title,
    required this.address,
    required this.date,
    required this.downloadInspectionOnTap,
    required this.shareInspectionOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey200Color,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextFontStyle.headlinePoppins50016),
              UIHelper.verticalSpace(4.h),
              Row(
                children: [
                  Text(
                    address,
                    style: TextFontStyle.headlinePoppins40014.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  CircleAvatar(radius: 4.r, backgroundColor: AppColors.grey500),
                  UIHelper.horizontalSpace(8.w),
                  Text(
                    date,
                    style: TextFontStyle.headlinePoppins40014.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(20.h),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        downloadInspectionOnTap();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey300,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 10.w,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.downloadIcon),
                              UIHelper.horizontalSpace(4.w),
                              Text(
                                'Download',
                                style: TextFontStyle.headlinePoppins50014
                                    .copyWith(color: AppColors.grey800),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        shareInspectionOnTap();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.grey300,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 10.w,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(AppIcons.shareIcon),
                              UIHelper.horizontalSpace(4.w),
                              Text(
                                'Share',
                                style: TextFontStyle.headlinePoppins50014
                                    .copyWith(color: AppColors.grey800),
                              ),
                            ],
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
      ),
    );
  }
}
