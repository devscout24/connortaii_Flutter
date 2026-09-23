import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ReportGeneratedScreen extends StatefulWidget {
  const ReportGeneratedScreen({super.key});

  @override
  State<ReportGeneratedScreen> createState() => _ReportGeneratedScreenState();
}

class _ReportGeneratedScreenState extends State<ReportGeneratedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Column(
          children: [
            UIHelper.verticalSpace(80.h),
            Stack(
              children: [
                Center(child: Image.asset(AppIcons.reportGenerateIcon)),
                Positioned(
                  left: 100,
                  right: 100,
                  bottom: 30,
                  child: Text(
                    'Report Generated',
                    style: TextFontStyle.headlinePoppins60020,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey200Color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.pdfIcon),
                        Text(
                          'Report.pdf',
                          style: TextFontStyle.headlinePoppins50016,
                        ),
                      ],
                    ),
                    UIHelper.verticalSpace(16.h),
                    CustomIconButton(
                      onTap: () {},
                      title: 'Download pdf',
                      image: AppIcons.downloadPdfIcon,
                    ),
                    UIHelper.verticalSpace(8.h),
                    CustomIconButton(
                      onTap: () {},
                      title: 'Share',
                      image: AppIcons.shareIcon,
                      fillColor: AppColors.cFFFFFF,
                      textColor: AppColors.c000000,
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            CustomButton(
              onTap: () {
                NavigationService.navigateTo(Routes.navigationScreen);
              },
              title: 'Back to home',
              fillColor: AppColors.cFFFFFF,
              textColor: AppColors.c000000,
              borderColor: AppColors.grey300,
            ),
            UIHelper.verticalSpace(48.h),
          ],
        ),
      ),
    );
  }
}
