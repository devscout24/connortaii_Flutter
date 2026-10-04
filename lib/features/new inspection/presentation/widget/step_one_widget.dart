import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/assets_helper/app_icons.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:validator_kit/validator_kit.dart';

class StepOneWidget extends StatelessWidget {
  const StepOneWidget({
    super.key,
    required this.inspectorNameController,
    required this.emailController,
    required this.mobileController,
    required this.addressController,
    required this.propertyNameController,
    required this.inspectionDateController,
    required this.propertyOwnerNameController,
    required this.propertyOwnerPresenceValue,
    required this.onPropertyOwnerPresenceChanged,
    required this.otherPeoplePresenceController,
    required this.houseOccupiedValue,
    required this.onHouseOccupiedChanged,
    required this.wasPropertyFurnishedValue,
    required this.onWasPropertyFurnishedChanged,
    required this.buildingTypeController,
    required this.statusOfUtilitiesController,
    required this.weatherDuringInspectionController,
  });

  final TextEditingController inspectorNameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController addressController;
  final TextEditingController propertyNameController;
  final TextEditingController inspectionDateController;
  final TextEditingController propertyOwnerNameController;
  final String? propertyOwnerPresenceValue;
  final Function(String?) onPropertyOwnerPresenceChanged;
  final TextEditingController otherPeoplePresenceController;
  final String? houseOccupiedValue;
  final Function(String?) onHouseOccupiedChanged;
  final String? wasPropertyFurnishedValue;
  final Function(String?) onWasPropertyFurnishedChanged;
  final TextEditingController buildingTypeController;
  final TextEditingController statusOfUtilitiesController;
  final TextEditingController weatherDuringInspectionController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Fill up the Inspection details',
              style: TextFontStyle.headlinePoppins60018,
            ),
          ),
          UIHelper.verticalSpace(16.h),
          UIHelper.customDivider(color: AppColors.grey300),
          UIHelper.verticalSpace(16.h),
          Text('Inspector Name *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: inspectorNameController,
            hintText: 'Inspector Name',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.combine([
              ValidatorKit.required(),
              ValidatorKit.username(),
            ]),
          ),
          UIHelper.verticalSpace(12.h),
          Text('Email *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.combine([
              ValidatorKit.required(),
              ValidatorKit.email(),
            ]),
          ),
          UIHelper.verticalSpace(12.h),
          Text('Mobile Number *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: mobileController,
            hintText: 'Enter number',
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Property Address *',
                style: TextFontStyle.headlinePoppins50016,
              ),
              Row(
                children: [
                  SvgPicture.asset(AppIcons.locationIcon),
                  Text(
                    'Use Current Location',
                    style: TextFontStyle.headlinePoppins50016,
                  ),
                ],
              ),
            ],
          ),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: addressController,
            hintText: 'Enter Property Address ',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text('Property Name *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: propertyNameController,
            hintText: 'Enter Property Address',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text('Inspection Date *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: inspectionDateController,
            hintText: 'mm/dd/yyyy',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Property Owner Name *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: propertyOwnerNameController,
            hintText: 'Property Owner Name',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Property Owner Presence *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.grey300),
            ),
            child: DropdownButton<String>(
              value: propertyOwnerPresenceValue,
              isExpanded: true,
              underline: SizedBox.shrink(),
              hint: Text(
                'Select Yes or No',
                style: TextFontStyle.headlinePoppins50016.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              items: ['Yes', 'No'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextFontStyle.headlinePoppins50016),
                );
              }).toList(),
              onChanged: onPropertyOwnerPresenceChanged,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Other People Presence *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: otherPeoplePresenceController,
            hintText: 'Describe...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text('House Occupied *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.grey300),
            ),
            child: DropdownButton<String>(
              value: houseOccupiedValue,
              isExpanded: true,
              underline: SizedBox.shrink(),
              hint: Text(
                'Select Yes or No',
                style: TextFontStyle.headlinePoppins50016.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              items: ['Yes', 'No'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextFontStyle.headlinePoppins50016),
                );
              }).toList(),
              onChanged: onHouseOccupiedChanged,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Was the Property Furnished? *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.grey300),
            ),
            child: DropdownButton<String>(
              value: wasPropertyFurnishedValue,
              isExpanded: true,
              underline: SizedBox.shrink(),
              hint: Text(
                'Select Yes or No',
                style: TextFontStyle.headlinePoppins50016.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              items: ['Yes', 'No'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextFontStyle.headlinePoppins50016),
                );
              }).toList(),
              onChanged: onWasPropertyFurnishedChanged,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Text('Building Type *', style: TextFontStyle.headlinePoppins50016),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: buildingTypeController,
            hintText: 'Enter building type...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Status of Utilities *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: statusOfUtilitiesController,
            hintText: 'Enter status...',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Weather During Inspection *',
            style: TextFontStyle.headlinePoppins50016,
          ),
          UIHelper.verticalSpace(8.h),
          CustomTextFormField(
            controller: weatherDuringInspectionController,
            hintText: 'e.g “Sunny, Cloudy, Rainy or Windy”',
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            fillColor: AppColors.cFFFFFF,
            validator: ValidatorKit.required(),
          ),
          UIHelper.verticalSpace(12.h),
        ],
      ),
    );
  }
}
