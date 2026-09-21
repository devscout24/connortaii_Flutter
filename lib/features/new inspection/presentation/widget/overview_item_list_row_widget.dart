import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OverviewItemListRowWidget extends StatelessWidget {
  final String index;
  final String title;
  final String status;
  final VoidCallback onTap;
  const OverviewItemListRowWidget({
    super.key,
    required this.title,
    required this.status,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey200Color,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        index,
                        style: TextFontStyle.headlinePoppins50012,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Text(title, style: TextFontStyle.headlinePoppins60014),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey200Color,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        status,
                        style: TextFontStyle.headlinePoppins50012,
                      ),
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  SvgPicture.asset(AppIcons.arrowLeftIcon),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
