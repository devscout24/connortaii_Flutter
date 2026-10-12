import 'dart:io';

import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/level_button_widget.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class BuildSectionCard extends StatelessWidget {
  final int number;
  final String title;
  final bool expanded;
  final VoidCallback onToggle;
  final TextEditingController typeController;
  final String levelOfConcern;
  final TextEditingController observationController;
  final List<XFile> _imageFileList;
  final VoidCallback greenOntap;
  final VoidCallback orangeOntap;
  final VoidCallback redOntap;
  final VoidCallback nAOntap;
  final VoidCallback imagePickerOntap;

  const BuildSectionCard({
    super.key,
    required this.number,
    required this.title,
    required this.expanded,
    required this.onToggle,
    required this.typeController,
    required this.levelOfConcern,
    required this.observationController,
    required this._imageFileList,
    required this.greenOntap,
    required this.orangeOntap,
    required this.redOntap,
    required this.nAOntap,
    required this.imagePickerOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.customDivider(color: AppColors.grey300),
                    UIHelper.verticalSpace(16.h),
                    Text('Type', style: TextFontStyle.headlinePoppins50016),
                    UIHelper.verticalSpace(8.h),
                    CustomTextFormField(
                      controller: typeController,
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
                        Expanded(
                          child: LevelButtonWidget(
                            label: 'Green',
                            iconSelected: AppIcons.greenUnselectedIcon,
                            iconUnselected: AppIcons.greenSelectedIcon,
                            color: AppColors.green500.withAlpha(35),
                            selected: levelOfConcern == 'Green',
                            onTap: () {
                              greenOntap();
                            },
                            textColor: AppColors.green500,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: LevelButtonWidget(
                            label: 'Orange',
                            iconSelected: AppIcons.orangeUnselectedIcon,
                            iconUnselected: AppIcons.orangeSelectedIcon,
                            color: AppColors.onboardingTwoBg.withAlpha(35),
                            selected: levelOfConcern == 'Orange',
                            onTap: () {
                              orangeOntap();
                            },
                            textColor: AppColors.onboardingTwoBg,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        Expanded(
                          child: LevelButtonWidget(
                            label: 'Red',
                            iconSelected: AppIcons.redUnselectedIcon,
                            iconUnselected: AppIcons.redSelectedIcon,
                            color: AppColors.red.withAlpha(35),
                            selected: levelOfConcern == 'Red',
                            onTap: () {
                              redOntap();
                            },
                            textColor: AppColors.red,
                          ),
                        ),
                        UIHelper.horizontalSpace(8.w),
                        LevelButtonWidget(
                          label: 'N/A',
                          iconSelected: AppIcons.nAUnSelectedIcon,
                          iconUnselected: AppIcons.nASelectedIcon,
                          color: AppColors.c000000.withAlpha(35),
                          selected: levelOfConcern == 'N/A',
                          onTap: () {
                            nAOntap();
                          },
                          textColor: AppColors.c000000,
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
                      controller: observationController,
                      hintText: 'Describe the observations...',
                      maxline: 4,
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
                    GestureDetector(
                      onTap: () {
                        imagePickerOntap();
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                  SvgPicture.asset(AppIcons.uploadPhotoCamIcon),
                                  UIHelper.verticalSpace(6.h),
                                  Text(
                                    'Add',
                                    style: TextFontStyle.headlinePoppins40014
                                        .copyWith(color: AppColors.grey400),
                                  ),
                                ],
                              ),
                            ),
                            UIHelper.horizontalSpace(8.w),
                            if (_imageFileList.isNotEmpty) ...[
                              for (final image in _imageFileList)
                                Padding(
                                  padding: EdgeInsets.only(right: 8.w),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12.r),
                                    child: SizedBox(
                                      width: 78.w,
                                      height: 78.h,
                                      child: Image.file(
                                        File(image.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
