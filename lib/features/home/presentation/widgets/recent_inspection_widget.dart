import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_icon_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RecentInspectionWidget extends StatelessWidget {
  final String title;
  final String status;
  final String address;
  final String date;
  final String sectionCompleteValue;
  final int totalSections;
  final dynamic healthSafetyCompleted;
  final int? currentStep;
  final VoidCallback onTap;
  final bool isLoading;

  const RecentInspectionWidget({
    super.key,
    required this.title,
    required this.status,
    required this.address,
    required this.date,
    required this.sectionCompleteValue,
    this.totalSections = 10,
    this.healthSafetyCompleted,
    this.currentStep,
    required this.onTap,
    this.isLoading = false,
  });

  bool get isCompleted =>
      status.trim().toLowerCase() == 'completed';

  bool get isHsDone {
    final hs = healthSafetyCompleted;
    return hs == 1 || hs == true || hs == '1';
  }

  int get completedCount => int.tryParse(sectionCompleteValue) ?? 0;

  int get totalCount => totalSections > 0 ? totalSections : 10;

  double get progress => (completedCount / totalCount).clamp(0.0, 1.0);

  /// Computes active step: 1 (Details), 2 (Safety), or 3 (Sections)
  int get currentStepNumber {
    if (isCompleted) return 3;
    if (isHsDone) return 3;

    if (currentStep != null && currentStep! >= 1 && currentStep! <= 3) {
      if (currentStep == 1 && isHsDone) return 3;
      return currentStep!;
    }

    // If property name or address is present, step 1 was saved -> step 2
    final hasPropertyInfo =
        (title.isNotEmpty && !title.toLowerCase().contains('inspection #')) ||
            address.isNotEmpty;
    if (hasPropertyInfo) {
      return 2;
    }

    return 1;
  }

  bool get isStep1Done =>
      currentStepNumber > 1 ||
      isHsDone ||
      completedCount > 0 ||
      isCompleted ||
      (title.isNotEmpty && !title.toLowerCase().contains('inspection #')) ||
      address.isNotEmpty;

  bool get isStep2Done => isHsDone || completedCount > 0 || isCompleted;

  bool get isStep3Done =>
      (completedCount >= totalCount && totalCount > 0) || isCompleted;

  String _formatStatus(String raw) {
    if (raw.isEmpty) return 'In Progress';
    final formatted = raw.replaceAll('_', ' ');
    return formatted
        .split(' ')
        .map((w) => w.isNotEmpty
            ? '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}'
            : '')
        .join(' ');
  }

  String get _currentStageTitle {
    if (isCompleted) return 'Inspection Completed';
    switch (currentStepNumber) {
      case 1:
        return 'Step 1 of 3: Property Details';
      case 2:
        return 'Step 2 of 3: Health & Safety Check';
      case 3:
      default:
        if (isStep3Done) {
          return 'Step 3 of 3: All Sections Completed!';
        }
        return 'Step 3 of 3: Inspection Sections';
    }
  }

  String get _currentStageDescription {
    if (isCompleted) {
      return 'Inspection finished and report has been generated.';
    }
    switch (currentStepNumber) {
      case 1:
        return 'Property & inspector details in progress.';
      case 2:
        return 'Property details completed ✓. Complete safety checks to proceed.';
      case 3:
      default:
        if (isStep3Done) {
          return 'All $totalCount sections finished! Ready to generate inspection report.';
        }
        final remaining = totalCount - completedCount;
        return '$completedCount of $totalCount sections done • $remaining section${remaining == 1 ? '' : 's'} remaining.';
    }
  }

  String get _buttonTitle {
    if (isCompleted) return 'View Inspection Report';
    switch (currentStepNumber) {
      case 1:
        return 'Continue: Property Details';
      case 2:
        return 'Continue: Health & Safety';
      case 3:
      default:
        if (isStep3Done) {
          return 'Review & Generate Report';
        }
        return 'Continue Inspection';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.grey200Color,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: AppColors.grey300.withAlpha(90),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(14.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Title and Status Badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextFontStyle.headlinePoppins60016,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  UIHelper.horizontalSpace(8.w),
                  Container(
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.c00AA4D.withAlpha(30)
                          : AppColors.grey300,
                      borderRadius: BorderRadius.circular(21.r),
                      border: isCompleted
                          ? Border.all(color: AppColors.c00AA4D, width: 1)
                          : null,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    child: Text(
                      _formatStatus(status),
                      style: TextFontStyle.headlinePoppins50012.copyWith(
                        color: isCompleted
                            ? AppColors.c00AA4D
                            : AppColors.c000000,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpace(4.h),

              // Property address and date
              Row(
                children: [
                  if (address.isNotEmpty) ...[
                    Flexible(
                      child: Text(
                        address,
                        style: TextFontStyle.headlinePoppins40014.copyWith(
                          color: AppColors.grey500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    UIHelper.horizontalSpace(8.w),
                    CircleAvatar(radius: 3.r, backgroundColor: AppColors.grey500),
                    UIHelper.horizontalSpace(8.w),
                  ],
                  Text(
                    date,
                    style: TextFontStyle.headlinePoppins40014.copyWith(
                      color: AppColors.grey500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              UIHelper.verticalSpace(14.h),
              UIHelper.customDivider(color: AppColors.grey300),
              UIHelper.verticalSpace(14.h),

              // 3-Step Visual Progress Stepper
              _buildMiniStepper(),

              UIHelper.verticalSpace(14.h),

              // Detailed Progress Card
              _buildDetailCard(),

              UIHelper.verticalSpace(16.h),

              // Action button
              isLoading
                  ? Container(
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: AppColors.grey300,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SpinKitCircle(
                              color: AppColors.c000000,
                              size: 20.sp,
                            ),
                            UIHelper.horizontalSpace(10.w),
                            Text(
                              "Loading Inspection...",
                              style: TextFontStyle.headlinePoppins50014.copyWith(
                                color: AppColors.c000000,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : CustomIconButton(
                      onTap: onTap,
                      title: _buttonTitle,
                      borderRadius: BorderRadius.circular(12.r),
                      image: AppIcons.inspectionIcon,
                      fillColor: AppColors.c000000,
                      textColor: AppColors.cFFFFFF,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniStepper() {
    final step1Done = isStep1Done && currentStepNumber != 1;
    final step1Active = currentStepNumber == 1 && !isCompleted;

    final step2Done = isStep2Done && currentStepNumber != 2;
    final step2Active = currentStepNumber == 2 && !isCompleted;

    final step3Done = isStep3Done;
    final step3Active = currentStepNumber == 3 && !isStep3Done && !isCompleted;

    return Row(
      children: [
        _buildStepNode(
          stepNum: 1,
          title: 'Details',
          isDone: step1Done,
          isActive: step1Active,
        ),
        _buildStepConnector(step1Done || currentStepNumber > 1),
        _buildStepNode(
          stepNum: 2,
          title: 'Safety',
          isDone: step2Done,
          isActive: step2Active,
        ),
        _buildStepConnector(step2Done || currentStepNumber > 2),
        _buildStepNode(
          stepNum: 3,
          title: 'Sections',
          isDone: step3Done,
          isActive: step3Active,
        ),
      ],
    );
  }

  Widget _buildStepNode({
    required int stepNum,
    required String title,
    required bool isDone,
    required bool isActive,
  }) {
    Color circleBg;
    Widget circleChild;

    if (isDone) {
      circleBg = AppColors.c00AA4D;
      circleChild = Icon(Icons.check, size: 12.sp, color: Colors.white);
    } else if (isActive) {
      circleBg = AppColors.c000000;
      circleChild = Text(
        '$stepNum',
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      circleBg = AppColors.grey300;
      circleChild = Text(
        '$stepNum',
        style: TextStyle(
          color: AppColors.grey600,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    final statusText = isDone ? 'Done' : (isActive ? 'Active' : 'Pending');
    final statusColor = isDone
        ? AppColors.c00AA4D
        : (isActive ? AppColors.c000000 : AppColors.grey500);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.w,
          height: 24.h,
          decoration: BoxDecoration(
            color: circleBg,
            shape: BoxShape.circle,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.c000000.withAlpha(40),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(child: circleChild),
        ),
        UIHelper.verticalSpace(4.h),
        Text(
          title,
          style: TextFontStyle.headlinePoppins50012.copyWith(
            color: isActive ? AppColors.c000000 : AppColors.grey600,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        Text(
          statusText,
          style: TextStyle(
            fontSize: 10.sp,
            color: statusColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildStepConnector(bool isDone) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(bottom: 26.h),
        child: Container(
          height: 2.h,
          color: isDone ? AppColors.c00AA4D : AppColors.grey300,
        ),
      ),
    );
  }

  Widget _buildDetailCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.grey300.withAlpha(120),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: isCompleted || isStep3Done
                          ? AppColors.c00AA4D
                          : AppColors.cFF7A22,
                      shape: BoxShape.circle,
                    ),
                  ),
                  UIHelper.horizontalSpace(6.w),
                  Text(
                    _currentStageTitle,
                    style: TextFontStyle.headlinePoppins60012,
                  ),
                ],
              ),
              if (currentStepNumber == 3 && !isCompleted)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: progress == 1.0
                        ? AppColors.c00AA4D.withAlpha(20)
                        : AppColors.grey200Color,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    "${(progress * 100).toInt()}% Done",
                    style: TextFontStyle.headlinePoppins60012.copyWith(
                      color: progress == 1.0
                          ? AppColors.c00AA4D
                          : AppColors.c000000,
                    ),
                  ),
                ),
            ],
          ),
          UIHelper.verticalSpace(6.h),
          Text(
            _currentStageDescription,
            style: TextFontStyle.headlinePoppins40012.copyWith(
              color: AppColors.grey600,
            ),
          ),
          if (currentStepNumber == 3) ...[
            UIHelper.verticalSpace(10.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: LinearProgressIndicator(
                color: progress == 1.0
                    ? AppColors.c00AA4D
                    : AppColors.c000000,
                backgroundColor: AppColors.grey200Color,
                value: progress,
                minHeight: 6.h,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
