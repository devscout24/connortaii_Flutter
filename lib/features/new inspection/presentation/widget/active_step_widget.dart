import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActiveStepWidget extends StatelessWidget {
  final int activeStep;
  final ValueChanged<int>? onStepTapped;

  const ActiveStepWidget({
    super.key,
    required this.activeStep,
    this.onStepTapped,
  });

  static const int stepCount = 3;
  static const List<String> stepTitles = ['Step 1', 'Step 2', 'Step 3'];
  static const List<String> stepNames = ['Details', 'Safety', 'Overview'];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(stepCount, (index) {
        final isCompleted = index < activeStep;
        final isActive = index == activeStep;
        final isRemaining = index > activeStep;

        // Visual properties per state
        final Color badgeBgColor = isCompleted
            ? AppColors.c00AA4D
            : (isActive ? AppColors.buttonbgColor : AppColors.grey100);

        final Color barColor = isCompleted
            ? AppColors.c00AA4D
            : (isActive ? AppColors.buttonbgColor : AppColors.grey300);

        final Color titleColor = isCompleted
            ? AppColors.c000000
            : (isActive ? AppColors.buttonbgColor : AppColors.grey500);

        final String statusLabel = isCompleted
            ? 'Done'
            : (isActive ? 'Active' : 'Pending');

        final Color statusColor = isCompleted
            ? AppColors.c00AA4D
            : (isActive ? AppColors.buttonbgColor : AppColors.grey400);

        return Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onStepTapped != null ? () => onStepTapped!(index) : null,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: badgeBgColor,
                          shape: BoxShape.circle,
                          border: isRemaining
                              ? Border.all(
                                  color: AppColors.grey300,
                                  width: 1.5,
                                )
                              : null,
                          boxShadow: isActive
                              ? [
                                  BoxShadow(
                                    color: AppColors.buttonbgColor.withAlpha(80),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 13.sp,
                                )
                              : Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.grey500,
                                    fontSize: 11.sp,
                                    fontWeight: isActive
                                        ? FontWeight.bold
                                        : FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                      UIHelper.horizontalSpace(5.w),
                      Flexible(
                        child: Text(
                          stepTitles[index],
                          style: isActive
                              ? TextFontStyle.headlinePoppins60014.copyWith(
                                  color: titleColor,
                                  fontSize: 13.sp,
                                )
                              : TextFontStyle.headlinePoppins40014.copyWith(
                                  color: titleColor,
                                  fontWeight: isCompleted
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(3.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${stepNames[index]} • $statusLabel',
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10.sp,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : (isCompleted
                                  ? FontWeight.w500
                                  : FontWeight.w400),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(6.h),
                  Container(
                    height: isActive || isCompleted ? 4.h : 3.h,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
