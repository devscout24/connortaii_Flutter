import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildHeightSafetyCardWidget extends StatelessWidget {
  const BuildHeightSafetyCardWidget({
    super.key,
    required this.isChecked,
    required this.isExpanded,
    required this.isSaved,
    required this.isRestrictionAccepted,
    required this.controller,
    required this.onCheckChanged,
    required this.onReportConcern,
    required this.onCancelConcern,
    required this.onSaveConcern,
    required this.onEditConcern,
    required this.onClearConcern,
    required this.onStopInspection,
    required this.onContinueRestriction,
    required this.onChangeRestriction,
  });

  final bool isChecked;
  final bool isExpanded;
  final bool isSaved;
  final bool isRestrictionAccepted;
  final TextEditingController controller;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onReportConcern;
  final VoidCallback onCancelConcern;
  final VoidCallback onSaveConcern;
  final VoidCallback onEditConcern;
  final VoidCallback onClearConcern;
  final VoidCallback onStopInspection;
  final VoidCallback onContinueRestriction;
  final VoidCallback onChangeRestriction;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: isSaved || isExpanded
            ? const Color(0xFFFFEDED)
            : AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(14.r),
        border: isSaved || isExpanded
            ? Border.all(color: AppColors.red, width: 1)
            : null,
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isSaved && !isExpanded)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 28.w,
                    height: 28.h,
                    child: Checkbox(
                      value: isChecked,
                      onChanged: onCheckChanged,
                      activeColor: AppColors.acceptedTextColor,
                      checkColor: AppColors.cFFFFFF,
                      side: BorderSide(color: AppColors.grey300, width: 2.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Height',
                                style: TextFontStyle.headlinePoppins60014,
                              ),
                            ),
                            UIHelper.horizontalSpace(6.w),
                            Text(
                              'Red Hazard',
                              style: TextFontStyle.headlinePoppins40010
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          'Required ladder or elevated access can be used safely.',
                          style: TextFontStyle.headlinePoppins40012.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        GestureDetector(
                          onTap: onReportConcern,
                          child: Text(
                            'Report Concern',
                            style: TextFontStyle.headlinePoppins50014.copyWith(
                              color: AppColors.reportConcernColor,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.reportConcernColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            else if (isExpanded && !isSaved)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                'Height',
                                style: TextFontStyle.headlinePoppins60014,
                              ),
                            ),
                            UIHelper.horizontalSpace(6.w),
                            Text(
                              'Red Hazard',
                              style: TextFontStyle.headlinePoppins40010
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    'Required ladder or elevated access can be used safely.',
                    style: TextFontStyle.headlinePoppins40012.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  UIHelper.customDivider(color: const Color(0xFFE8D8D8)),
                  UIHelper.verticalSpace(12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16.sp,
                        color: AppColors.red,
                      ),
                      UIHelper.horizontalSpace(6.w),
                      Text(
                        'Safety Concern',
                        style: TextFontStyle.headlinePoppins50012.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),
                  Text('Details', style: TextFontStyle.headlinePoppins50014),
                  UIHelper.verticalSpace(8.h),
                  CustomTextFormField(
                    controller: controller,
                    hintText: 'Describe the concern...',
                    hintStyle: TextFontStyle.headlinePoppins40014.copyWith(
                      color: AppColors.grey400,
                    ),
                    fillColor: AppColors.cFFFFFF,
                    maxline: 4,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    borderColor: AppColors.red.withAlpha(80),
                    borderRadius: 12.r,
                  ),
                  UIHelper.verticalSpace(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onCancelConcern,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.cFFFFFF,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextFontStyle.headlinePoppins50012,
                            ),
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(10.w),
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: onSaveConcern,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            decoration: BoxDecoration(
                              color: AppColors.c000000,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'Save Concern',
                              style: TextFontStyle.headlinePoppins50012
                                  .copyWith(color: AppColors.cFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Height',
                          style: TextFontStyle.headlinePoppins60014,
                        ),
                      ),
                      UIHelper.horizontalSpace(6.w),
                      Text(
                        'Red Hazard',
                        style: TextFontStyle.headlinePoppins40010.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    'Required ladder or elevated access can be used safely.',
                    style: TextFontStyle.headlinePoppins40012.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  UIHelper.verticalSpace(12.h),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16.sp,
                        color: AppColors.red,
                      ),
                      UIHelper.horizontalSpace(6.w),
                      Text(
                        'Concern',
                        style: TextFontStyle.headlinePoppins50012.copyWith(
                          color: AppColors.red,
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details:',
                        style: TextFontStyle.headlinePoppins50012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Expanded(
                        child: Text(
                          controller.text.isEmpty
                              ? 'No details provided'
                              : controller.text,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                          style: TextFontStyle.headlinePoppins50012.copyWith(
                            color: AppColors.grey700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(10.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: onEditConcern,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cFFFFFF,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Edit Concern',
                            style: TextFontStyle.headlinePoppins50012,
                          ),
                        ),
                      ),
                      UIHelper.horizontalSpace(10.w),
                      GestureDetector(
                        onTap: onClearConcern,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 18.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cFFFFFF,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Clear',
                            style: TextFontStyle.headlinePoppins50012,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(12.h),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.sp),
                    decoration: BoxDecoration(
                      color: AppColors.cFFFFFF,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 17.sp,
                              color: AppColors.red,
                            ),
                            UIHelper.horizontalSpace(6.w),
                            Text(
                              'Safety Concern',
                              style: TextFontStyle.headlinePoppins50012
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(12.h),
                        if (!isRestrictionAccepted) ...[
                          Text(
                            'This condition may prevent the inspection from being completed safely.',
                            style: TextFontStyle.headlinePoppins40012.copyWith(
                              color: AppColors.grey500,
                            ),
                          ),
                          UIHelper.verticalSpace(12.h),
                          GestureDetector(
                            onTap: onStopInspection,
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Stop inspection',
                                style: TextFontStyle.headlinePoppins50012
                                    .copyWith(color: AppColors.cFFFFFF),
                              ),
                            ),
                          ),
                          UIHelper.verticalSpace(8.h),
                          GestureDetector(
                            onTap: onContinueRestriction,
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: AppColors.grey200Color,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'Continue with restriction',
                                style: TextFontStyle.headlinePoppins50012,
                              ),
                            ),
                          ),
                        ] else
                          Column(
                            children: [
                              Text(
                                'This condition may prevent the inspection from being completed safely.',
                                style: TextFontStyle.headlinePoppins40012
                                    .copyWith(color: AppColors.grey500),
                              ),
                              UIHelper.verticalSpace(12.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.grey200Color,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Continuing with safety restriction',
                                        style: TextFontStyle
                                            .headlinePoppins40012
                                            .copyWith(color: AppColors.grey500),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: onChangeRestriction,
                                      child: Text(
                                        'Change',
                                        style:
                                            TextFontStyle.headlinePoppins50012,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
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
