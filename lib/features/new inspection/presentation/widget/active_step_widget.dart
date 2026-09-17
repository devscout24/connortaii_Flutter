import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveStepWidget extends StatelessWidget {
  const ActiveStepWidget({super.key, required this._activeStep});

  final int _activeStep;
  static const int stepCount = 3;

  static final List<String> steps = ['Step 1', 'Step 2', 'Step 3'];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(stepCount, (index) {
          final isCompleted = index < _activeStep;
          final isActive = index == _activeStep;

          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  steps[index],
                  style: isActive || isCompleted
                      ? TextFontStyle.headlinePoppins40014.copyWith(
                          color: AppColors.c000000,
                        )
                      : TextFontStyle.headlinePoppins40014.copyWith(
                          color: AppColors.grey500,
                        ),
                ),
                UIHelper.verticalSpace(4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Container(
                    height: 3.h,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.c000000
                          : AppColors.grey300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
