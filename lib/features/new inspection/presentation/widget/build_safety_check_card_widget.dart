import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildSafetyCheckCardWidget extends StatelessWidget {
  const BuildSafetyCheckCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.isChecked,
    required this.isExpanded,
    required this.isSaved,
    required this.controller,
    required this.onCheckChanged,
    required this.onToggleExpanded,
    required this.onCancel,
    required this.onSave,
    required this.onEdit,
    required this.onClear,
    this.isRedHazard = false,
  });

  final String title;
  final String description;
  final bool isChecked;
  final bool isExpanded;
  final bool isSaved;
  final TextEditingController controller;
  final ValueChanged<bool?> onCheckChanged;
  final VoidCallback onToggleExpanded;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final VoidCallback onEdit;
  final VoidCallback onClear;
  final bool isRedHazard;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: double.infinity,
      padding: EdgeInsets.all(14.sp),
      decoration: BoxDecoration(
        color: isSaved
            ? const Color(0xFFFFF0E2)
            : isExpanded
            ? const Color(0xFFFFF3E8)
            : AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(14.r),
        border: isExpanded || isSaved
            ? Border.all(color: const Color(0xFFFFB46F), width: 1)
            : null,
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSaved)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextFontStyle.headlinePoppins60014),
                  UIHelper.verticalSpace(4.h),
                  Text(
                    description,
                    style: TextFontStyle.headlinePoppins40012.copyWith(
                      color: AppColors.grey500,
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE1C2),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: 14.sp,
                          color: Colors.orange,
                        ),
                        UIHelper.horizontalSpace(5.w),
                        Text(
                          'Concern Reported',
                          style: TextFontStyle.headlinePoppins50010.copyWith(
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  UIHelper.verticalSpace(10.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details:',
                        style: TextFontStyle.headlinePoppins50012.copyWith(
                          color: AppColors.grey400,
                        ),
                      ),
                      UIHelper.horizontalSpace(8.w),
                      Expanded(
                        child: Text(
                          controller.text.isEmpty
                              ? 'No details provided'
                              : controller.text,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextFontStyle.headlinePoppins40012.copyWith(
                            color: AppColors.grey700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  UIHelper.verticalSpace(10.h),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: onEdit,
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
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
                      ),
                      UIHelper.horizontalSpace(10.w),
                      GestureDetector(
                        onTap: onClear,
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
                ],
              )
            else
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
                      side: BorderSide(color: AppColors.grey300, width: 2),
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
                        if (isRedHazard)
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  title,
                                  style: TextFontStyle.headlinePoppins60014,
                                ),
                              ),
                              UIHelper.horizontalSpace(8.w),
                              Text(
                                'Red Hazard',
                                style: TextFontStyle.headlinePoppins40010
                                    .copyWith(color: AppColors.red),
                              ),
                            ],
                          )
                        else
                          Text(
                            title,
                            style: TextFontStyle.headlinePoppins60014,
                          ),
                        UIHelper.verticalSpace(4.h),
                        Text(
                          description,
                          style: TextFontStyle.headlinePoppins40012.copyWith(
                            color: AppColors.grey500,
                          ),
                        ),
                        if (isExpanded)
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                UIHelper.customDivider(
                                  color: AppColors.grey300,
                                ),
                                UIHelper.verticalSpace(12.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 16.sp,
                                      color: isRedHazard
                                          ? AppColors.red
                                          : Colors.orange,
                                    ),
                                    UIHelper.horizontalSpace(6.w),
                                    Text(
                                      'Safety Concern',
                                      style: TextFontStyle.headlinePoppins50012
                                          .copyWith(
                                            color: isRedHazard
                                                ? AppColors.red
                                                : Colors.orange,
                                          ),
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpace(12.h),
                                Text(
                                  'Details',
                                  style: TextFontStyle.headlinePoppins50012,
                                ),
                                UIHelper.verticalSpace(6.h),
                                TextField(
                                  controller: controller,
                                  maxLines: 4,
                                  textInputAction: TextInputAction.newline,
                                  style: TextFontStyle.headlinePoppins40012,
                                  decoration: InputDecoration(
                                    hintText: 'Describe the concern...',
                                    hintStyle: TextFontStyle
                                        .headlinePoppins40012
                                        .copyWith(color: AppColors.grey400),
                                    filled: true,
                                    fillColor: AppColors.cFFFFFF,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 12.h,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9.r),
                                      borderSide: BorderSide(
                                        color: isRedHazard
                                            ? AppColors.red
                                            : Colors.orange,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                UIHelper.verticalSpace(10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: onCancel,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.cFFFFFF,
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Text(
                                            'Cancel',
                                            style: TextFontStyle
                                                .headlinePoppins50012,
                                          ),
                                        ),
                                      ),
                                    ),
                                    UIHelper.horizontalSpace(10.w),
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        onTap: onSave,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.c000000,
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Text(
                                            'Save Concern',
                                            style: TextFontStyle
                                                .headlinePoppins50012
                                                .copyWith(
                                                  color: AppColors.cFFFFFF,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        else
                          Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: GestureDetector(
                              onTap: onToggleExpanded,
                              child: Text(
                                'Report Concern',
                                style: TextFontStyle.headlinePoppins50014
                                    .copyWith(
                                      color: isChecked
                                          ? AppColors.grey400
                                          : Colors.orange,
                                      decoration: TextDecoration.underline,
                                      decorationColor: isChecked
                                          ? AppColors.grey400
                                          : Colors.orange,
                                    ),
                              ),
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
    );
  }
}
