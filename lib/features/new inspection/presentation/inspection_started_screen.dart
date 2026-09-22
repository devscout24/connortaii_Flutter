import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_accessibitlity_button_widget.dart';
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
  bool isRestricted = false;
  String selectedRestrictionReason = '';
  final TextEditingController restrictionController = TextEditingController();

  final List<String> restrictionReasons = [
    'Limited Access',
    'Obstruction',
    'Safety Concern',
    'Concealed Element',
    'Height',
    'Confined Space',
    'Other',
  ];

  @override
  void dispose() {
    restrictionController.dispose();
    super.dispose();
  }

  Widget _buildReasonChip({
    required String reason,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(28.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.c000000 : AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Text(
          reason,
          style: isSelected
              ? TextFontStyle.headlinePoppins50014.copyWith(
                  color: AppColors.cFFFFFF,
                )
              : TextFontStyle.headlinePoppins40014,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBarWidget(title: widget.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.grey200Color,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Section Accessibility',
                        style: TextFontStyle.headlinePoppins60018,
                      ),
                      UIHelper.verticalSpace(8.h),
                      Text(
                        'Was the full section accessible for inspection?',
                        style: TextFontStyle.headlinePoppins40014,
                      ),
                      UIHelper.verticalSpace(16.h),
                      Row(
                        children: [
                          BuildAccessibilityButton(
                            title: 'Yes, Accessible',
                            isSelected: !isRestricted,
                            isRestrictedButton: false,
                            onTap: () {
                              setState(() => isRestricted = false);
                            },
                          ),
                          UIHelper.horizontalSpace(8.w),
                          BuildAccessibilityButton(
                            title: 'No, Restricted',
                            isSelected: isRestricted,
                            isRestrictedButton: true,
                            onTap: () {
                              setState(() => isRestricted = true);
                            },
                          ),
                        ],
                      ),
                      if (isRestricted) ...[
                        UIHelper.verticalSpace(16.h),
                        UIHelper.customDivider(color: AppColors.grey300),
                        UIHelper.verticalSpace(16.h),
                        Row(
                          children: [
                            Icon(
                              Icons.warning_amber_rounded,
                              color: AppColors.red500,
                              size: 18.sp,
                            ),
                            UIHelper.horizontalSpace(6.w),
                            Text(
                              'Inspection Restricted',
                              style: TextFontStyle.headlinePoppins50014
                                  .copyWith(color: AppColors.red),
                            ),
                          ],
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          'Restriction Reason',
                          style: TextFontStyle.headlinePoppins50016,
                        ),
                        UIHelper.verticalSpace(8.h),
                        Wrap(
                          spacing: 12.w,
                          runSpacing: 12.h,
                          children: restrictionReasons.map((reason) {
                            final bool isSelected =
                                selectedRestrictionReason == reason;
                            return _buildReasonChip(
                              reason: reason,
                              isSelected: isSelected,
                              onTap: () => setState(
                                () => selectedRestrictionReason = reason,
                              ),
                            );
                          }).toList(),
                        ),
                        UIHelper.verticalSpace(16.h),
                        UIHelper.customDivider(color: AppColors.grey300),
                        UIHelper.verticalSpace(16.h),
                        Text(
                          'Describe',
                          style: TextFontStyle.headlinePoppins50016,
                        ),
                        UIHelper.verticalSpace(8.h),
                        CustomTextFormField(
                          controller: restrictionController,
                          maxline: 4,
                          hintText: 'Describe the restriction...',
                          hintStyle: TextFontStyle.headlinePoppins40014
                              .copyWith(color: AppColors.grey400),
                          fillColor: AppColors.cFFFFFF,
                          borderColor: AppColors.grey300,
                          isBorder: true,
                          borderRadius: 12.r,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              UIHelper.verticalSpace(18.h),
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    decoration: BoxDecoration(
                      color: AppColors.c000000,
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Text(
                      'Save Section',
                      style: TextFontStyle.headlinePoppins60024.copyWith(
                        color: AppColors.cFFFFFF,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
