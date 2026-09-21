import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InspectionStartedScreen extends StatefulWidget {
  final String title;
  const InspectionStartedScreen({super.key, required this.title});

  @override
  State<InspectionStartedScreen> createState() =>
      _InspectionStartedScreenState();
}

class _InspectionStartedScreenState extends State<InspectionStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: widget.title),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.grey200Color,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Section Accessiblity',
                  style: TextFontStyle.headlinePoppins60018,
                ),
                UIHelper.verticalSpace(8.h),
                Text(
                  'Was the full section accessible for inspection?',
                  style: TextFontStyle.headlinePoppins40014,
                ),
                UIHelper.verticalSpace(16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cFFFFFF,
                          borderRadius: BorderRadius.circular(52.r),
                          border: Border.all(color: AppColors.grey300),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Text(
                            'Yes, Fully Accessible',
                            style: TextFontStyle.headlinePoppins40014,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    UIHelper.horizontalSpace(8.h),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cFFFFFF,
                          borderRadius: BorderRadius.circular(52.r),
                          border: Border.all(color: AppColors.grey300),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 10.h,
                          ),
                          child: Text(
                            'No, Restricted',
                            style: TextFontStyle.headlinePoppins40014,
                            textAlign: TextAlign.center,
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
      ),
    );
  }
}
