import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/active_step_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/step_one_widget.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewInspectionScreen extends StatefulWidget {
  const NewInspectionScreen({super.key});

  @override
  State<NewInspectionScreen> createState() => _NewInspectionScreenState();
}

class _NewInspectionScreenState extends State<NewInspectionScreen> {
  int _activeStep = 0;

  //step 1
  final TextEditingController inspectorNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController propertyNameController = TextEditingController();
  final TextEditingController inspectionDateController =
      TextEditingController();
  final TextEditingController propertyOwnerNameController =
      TextEditingController();
  final TextEditingController propertyOwnerPresenceController =
      TextEditingController();
  final TextEditingController otherPeoplePresenceController =
      TextEditingController();
  final TextEditingController houseOccupiedController = TextEditingController();
  final TextEditingController wasPropertyFurnishedController =
      TextEditingController();
  final TextEditingController buildingTypeController = TextEditingController();
  final TextEditingController statusOfUtilitiesController =
      TextEditingController();
  final TextEditingController weatherDuringInspectionController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  //step 2
  bool isIdentifiableChecked = false;
  bool isPhoneTabletChecked = false;
  bool isToolsChecked = false;
  bool isPPEChecked = false;
  bool isPropertyOccupantsChecked = false;
  bool isHeightChecked = false;
  bool isElectricityChecked = false;
  bool isSlipTripFallsChecked = false;
  bool isChemicalsChecked = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _nextStep() {
    // if (_activeStep == 0 && inspectorNameController.text.trim().isEmpty) {
    //   _showMessage('Please enter an inspection name');
    //   return;
    // }

    // if (_activeStep == 1 && addressController.text.trim().isEmpty) {
    //   _showMessage('Please enter the property address');
    //   return;
    // }

    // if (_activeStep == 2 && propertyNameController.text.trim().isEmpty) {
    //   _showMessage('Please enter the property name');
    //   return;
    // }

    if (_activeStep < 2) {
      setState(() => _activeStep++);
      return;
    }

    _submitInspection();
  }

  void _previousStep() {
    if (_activeStep > 0) {
      setState(() => _activeStep--);
    }
  }

  void _submitInspection() {
    final payload = {
      'inspectionName': inspectorNameController.text.trim(),
      'inspectorEmail': emailController.text.trim(),
      'address': addressController.text.trim(),
      'mobileNumber': mobileController.text.trim(),
      'propertyName': propertyNameController.text.trim(),
    };

    debugPrint('Inspection payload: $payload');
    _showMessage('Inspection saved successfully');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildStepTwo() {
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
              'Health & Safety Check',
              style: TextFontStyle.headlinePoppins60018,
            ),
          ),
          Center(
            child: Text(
              'Confirm each safety condition before starting.',
              style: TextFontStyle.headlinePoppins40012.copyWith(
                color: AppColors.grey500,
              ),
            ),
          ),
          UIHelper.verticalSpace(16.h),
          UIHelper.customDivider(color: AppColors.grey300),
          UIHelper.verticalSpace(16.h),
          Text(
            '1 of 9 checks completed',
            style: TextFontStyle.headlinePoppins50014,
          ),
          UIHelper.verticalSpace(8.h),
          LinearProgressIndicator(
            minHeight: 6.h,
            backgroundColor: AppColors.cFFFFFF,
            color: AppColors.c000000,
            borderRadius: BorderRadius.circular(16.r),
            value: 1 / 9,
          ),
          UIHelper.verticalSpace(16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isIdentifiableChecked,
                    onChanged: (value) {
                      setState(() {
                        isIdentifiableChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Identifiable',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'I have my uniform and name badge on.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: AppColors.grey400,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.grey500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isPhoneTabletChecked,
                    onChanged: (value) {
                      setState(() {
                        isPhoneTabletChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Phone / Tablet',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'My iPad and phone are working and charged.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isToolsChecked,
                    onChanged: (value) {
                      setState(() {
                        isToolsChecked = value ?? false;
                      });
                    },
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
                      Text('Tools', style: TextFontStyle.headlinePoppins60014),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'My tools are available and in working condition.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isPPEChecked,
                    onChanged: (value) {
                      setState(() {
                        isPPEChecked = value ?? false;
                      });
                    },
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
                      Text('PPE', style: TextFontStyle.headlinePoppins60014),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'Required PPE is available and ready to use.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isPropertyOccupantsChecked,
                    onChanged: (value) {
                      setState(() {
                        isPropertyOccupantsChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Property Occupants',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'I am aware of the occupants and have considered their presence.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isHeightChecked,
                    onChanged: (value) {
                      setState(() {
                        isHeightChecked = value ?? false;
                      });
                    },
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
                      Row(
                        children: [
                          Text(
                            'Height',
                            style: TextFontStyle.headlinePoppins60014,
                          ),
                          UIHelper.horizontalSpace(10.w),
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
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isElectricityChecked,
                    onChanged: (value) {
                      setState(() {
                        isElectricityChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Electricity',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'Potential electrical hazards have been considered.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isSlipTripFallsChecked,
                    onChanged: (value) {
                      setState(() {
                        isSlipTripFallsChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Slips, Trips & Falls',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'Potential slip, trip or fall hazards have been considered.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.sp),
            decoration: BoxDecoration(
              color: AppColors.cFFFFFF,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 28.w,
                  height: 28.h,
                  child: Checkbox(
                    value: isChemicalsChecked,
                    onChanged: (value) {
                      setState(() {
                        isChemicalsChecked = value ?? false;
                      });
                    },
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
                      Text(
                        'Chemicals / Hazardous Substances',
                        style: TextFontStyle.headlinePoppins60014,
                      ),
                      UIHelper.verticalSpace(4.h),
                      Text(
                        'Potential chemical or hazardous substance risks have been considered.',
                        style: TextFontStyle.headlinePoppins40012.copyWith(
                          color: AppColors.grey500,
                        ),
                      ),
                      UIHelper.verticalSpace(8.h),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Report Concern',
                          style: TextFontStyle.headlinePoppins50014.copyWith(
                            color: Colors.orange,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.orange,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepThree() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_activeStep) {
      case 0:
        return StepOneWidget(
          inspectorNameController: inspectorNameController,
          emailController: emailController,
          mobileController: mobileController,
          addressController: addressController,
          propertyNameController: propertyNameController,
          inspectionDateController: inspectionDateController,
          propertyOwnerNameController: propertyOwnerNameController,
          propertyOwnerPresenceController: propertyOwnerPresenceController,
          otherPeoplePresenceController: otherPeoplePresenceController,
          houseOccupiedController: houseOccupiedController,
          wasPropertyFurnishedController: wasPropertyFurnishedController,
          buildingTypeController: buildingTypeController,
          statusOfUtilitiesController: statusOfUtilitiesController,
          weatherDuringInspectionController: weatherDuringInspectionController,
        );
      case 1:
        return _buildStepTwo();
      case 2:
        return _buildStepThree();
      default:
        return StepOneWidget(
          inspectorNameController: inspectorNameController,
          emailController: emailController,
          mobileController: mobileController,
          addressController: addressController,
          propertyNameController: propertyNameController,
          inspectionDateController: inspectionDateController,
          propertyOwnerNameController: propertyOwnerNameController,
          propertyOwnerPresenceController: propertyOwnerPresenceController,
          otherPeoplePresenceController: otherPeoplePresenceController,
          houseOccupiedController: houseOccupiedController,
          wasPropertyFurnishedController: wasPropertyFurnishedController,
          buildingTypeController: buildingTypeController,
          statusOfUtilitiesController: statusOfUtilitiesController,
          weatherDuringInspectionController: weatherDuringInspectionController,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBarWidget(
        title: 'New Inspection',
        leadingOnTap: () {
          if (_activeStep > 0) {
            _previousStep();
          } else {
            NavigationService.goBack;
          }
        },
        showLeadingIcon: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ActiveStepWidget(activeStep: _activeStep),
              UIHelper.verticalSpace(28.h),
              _buildCurrentStep(),
              UIHelper.verticalSpace(24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () {
                        _nextStep();
                      },
                      title: _activeStep == 2 ? 'Submit' : 'Continue',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
