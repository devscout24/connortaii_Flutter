import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_accessibitlity_button_widget.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

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

  String levelOfConcern = 'Green';
  bool sectionOneExpanded = true;

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

  // Widget _buildSmallSection(int number, String title) {
  //   return Container(
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: AppColors.cFFFFFF,
  //       borderRadius: BorderRadius.circular(12.r),
  //     ),
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
  //       child: Row(
  //         children: [
  //           Container(
  //             width: 32.w,
  //             height: 32.w,
  //             decoration: BoxDecoration(
  //               color: AppColors.grey80,
  //               borderRadius: BorderRadius.circular(12.r),
  //             ),
  //             alignment: Alignment.center,
  //             child: Text(
  //               number.toString(),
  //               style: TextFontStyle.headlinePoppins50014,
  //             ),
  //           ),
  //           UIHelper.horizontalSpace(12.w),
  //           Expanded(
  //             child: Text(title, style: TextFontStyle.headlinePoppins50016),
  //           ),
  //           Icon(
  //             Icons.arrow_forward_ios,
  //             size: 16.sp,
  //             color: AppColors.grey500,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBarWidget(
        title: widget.title,
        leadingOnTap: () {
          NavigationService.goBack;
        },
      ),
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
                            return BuildReasonChipWidget(
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
                      if (!isRestricted) ...[
                        UIHelper.verticalSpace(16.h),
                        // Accessible design: show form-like accordion sections
                        BuildSectionCard(
                          number: 1,
                          title: 'Roof Type / Material',
                          expanded: sectionOneExpanded,
                          onToggle: () => setState(
                            () => sectionOneExpanded = !sectionOneExpanded,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIHelper.verticalSpace(8.h),
                              Text(
                                'Type',
                                style: TextFontStyle.headlinePoppins50016,
                              ),
                              UIHelper.verticalSpace(8.h),
                              CustomTextFormField(
                                hintText: 'Type...',
                                maxline: 1,
                              ),
                              UIHelper.verticalSpace(12.h),
                              Text(
                                'Level of Concern',
                                style: TextFontStyle.headlinePoppins50016,
                              ),
                              UIHelper.verticalSpace(8.h),
                              Row(
                                children: [
                                  LevelButtonWidget(
                                    label: 'Green',
                                    iconSelected: AppIcons.greenSelectedIcon,
                                    iconUnselected:
                                        AppIcons.greenUnselectedIcon,
                                    color: AppColors.green500.withAlpha(55),
                                    selected: levelOfConcern == 'Green',
                                    onTap: () {
                                      setState(() {
                                        levelOfConcern = 'Green';
                                      });
                                    },
                                    textColor: AppColors.green500,
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  LevelButtonWidget(
                                    label: 'Orange',
                                    iconSelected: AppIcons.greenSelectedIcon,
                                    iconUnselected:
                                        AppIcons.greenUnselectedIcon,
                                    color: AppColors.onboardingTwoBg.withAlpha(
                                      55,
                                    ),
                                    selected: levelOfConcern == 'Orange',
                                    onTap: () {
                                      setState(() {
                                        levelOfConcern = 'Orange';
                                      });
                                    },
                                    textColor: AppColors.onboardingTwoBg,
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  LevelButtonWidget(
                                    label: 'Red',
                                    iconSelected: AppIcons.greenSelectedIcon,
                                    iconUnselected:
                                        AppIcons.greenUnselectedIcon,
                                    color: AppColors.red.withAlpha(55),
                                    selected: levelOfConcern == 'Red',
                                    onTap: () {
                                      setState(() {
                                        levelOfConcern = 'Red';
                                      });
                                    },
                                    textColor: AppColors.red,
                                  ),
                                  UIHelper.horizontalSpace(8.w),
                                  LevelButtonWidget(
                                    label: 'N/A',
                                    iconSelected: AppIcons.greenSelectedIcon,
                                    iconUnselected:
                                        AppIcons.greenUnselectedIcon,
                                    color: AppColors.red.withAlpha(55),
                                    selected: levelOfConcern == 'N/A',
                                    onTap: () {
                                      setState(() {
                                        levelOfConcern = 'N/A';
                                      });
                                    },
                                    textColor: AppColors.red,
                                  ),
                                ],
                              ),
                              UIHelper.verticalSpace(12.h),
                              Text(
                                'Observations',
                                style: TextFontStyle.headlinePoppins50016,
                              ),
                              UIHelper.verticalSpace(8.h),
                              CustomTextFormField(
                                hintText: 'Describe the observations...',
                                maxline: 4,
                                fillColor: AppColors.cFFFFFF,
                                isBorder: true,
                                borderColor: AppColors.grey300,
                                borderRadius: 12.r,
                              ),
                              UIHelper.verticalSpace(12.h),
                              Text(
                                'Upload Photo',
                                style: TextFontStyle.headlinePoppins50016,
                              ),
                              UIHelper.verticalSpace(8.h),
                              Container(
                                width: 78.w,
                                height: 78.h,
                                decoration: BoxDecoration(
                                  color: AppColors.cFFFFFF,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColors.grey300),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.grey400,
                                      size: 20.sp,
                                    ),
                                    UIHelper.verticalSpace(6.h),
                                    Text(
                                      'Add',
                                      style: TextFontStyle.headlinePoppins40014
                                          .copyWith(color: AppColors.grey400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpace(16.h),
                        // Other collapsed sections
                        // _buildSmallSection(2, 'Overall Condition'),
                        // UIHelper.verticalSpace(12.h),
                        // _buildSmallSection(3, 'Roof Covering'),
                        // UIHelper.verticalSpace(12.h),
                        // _buildSmallSection(4, 'Gutters & Downpipes'),
                        UIHelper.verticalSpace(16.h),
                        UIHelper.customDivider(color: AppColors.grey300),
                        UIHelper.verticalSpace(16.h),
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
                    padding: EdgeInsets.symmetric(vertical: 14.h),
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

class LevelButtonWidget extends StatelessWidget {
  final String label;
  final String iconSelected;
  final String iconUnselected;
  final Color color;
  final Color textColor;
  final bool selected;
  final VoidCallback onTap;

  const LevelButtonWidget({
    super.key,
    required this.label,
    required this.iconSelected,
    required this.iconUnselected,
    required this.color,
    required this.selected,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: selected ? color : AppColors.cFFFFFF,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: selected ? color : AppColors.grey300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            selected
                ? SvgPicture.asset(iconUnselected)
                : SvgPicture.asset(iconSelected),
            UIHelper.verticalSpace(6.h),
            Text(
              label,
              style: selected
                  ? TextFontStyle.headlinePoppins50014.copyWith(
                      color: selected ? textColor : AppColors.cFFFFFF,
                    )
                  : TextFontStyle.headlinePoppins40014,
            ),
          ],
        ),
      ),
    );
  }
}

class BuildReasonChipWidget extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final VoidCallback onTap;
  const BuildReasonChipWidget({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}

class BuildSectionCard extends StatelessWidget {
  final int number;
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final Widget child;
  const BuildSectionCard({
    super.key,
    required this.number,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey80,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      number.toString(),
                      style: TextFontStyle.headlinePoppins50014,
                    ),
                  ),
                  UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextFontStyle.headlinePoppins50016,
                    ),
                  ),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.grey700,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: child,
            ),
        ],
      ),
    );
  }
}
