import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/active_step_widget.dart';
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

  final TextEditingController _inspectionNameController =
      TextEditingController();
  final TextEditingController _inspectorNameController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _checklistController = TextEditingController();

  final List<String> _inspectionTypes = [
    'Residential',
    'Commercial',
    'Industrial',
  ];

  String _selectedInspectionType = 'Residential';

  @override
  void dispose() {
    _inspectionNameController.dispose();
    _inspectorNameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    _checklistController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_activeStep == 0 && _inspectionNameController.text.trim().isEmpty) {
      _showMessage('Please enter an inspection name');
      return;
    }

    if (_activeStep == 1 && _addressController.text.trim().isEmpty) {
      _showMessage('Please enter the property address');
      return;
    }

    if (_activeStep == 2 && _checklistController.text.trim().isEmpty) {
      _showMessage('Please add the inspection checklist');
      return;
    }

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
      'inspectionName': _inspectionNameController.text.trim(),
      'inspectorName': _inspectorNameController.text.trim(),
      'inspectionType': _selectedInspectionType,
      'address': _addressController.text.trim(),
      'notes': _notesController.text.trim(),
      'checklist': _checklistController.text.trim(),
    };

    debugPrint('Inspection payload: $payload');
    _showMessage('Inspection saved successfully');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        filled: true,
        fillColor: AppColors.grey50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildStepOne() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inspection Details',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          UIHelper.verticalSpace(16.h),
          _buildTextField(
            controller: _inspectionNameController,
            label: 'Inspection Name',
            hintText: 'Enter inspection name',
          ),
          UIHelper.verticalSpace(16.h),
          _buildTextField(
            controller: _inspectorNameController,
            label: 'Inspector Name',
            hintText: 'Enter inspector name',
          ),
        ],
      ),
    );
  }

  Widget _buildStepTwo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.cFFFFFF,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Property Information',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          UIHelper.verticalSpace(16.h),
          DropdownButtonFormField<String>(
            initialValue: _inspectionTypes.contains(_selectedInspectionType)
                ? _selectedInspectionType
                : _inspectionTypes.first,
            decoration: InputDecoration(
              labelText: 'Inspection Type',
              filled: true,
              fillColor: AppColors.grey50,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
            items: _inspectionTypes
                .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedInspectionType = value);
              }
            },
          ),
          UIHelper.verticalSpace(16.h),
          _buildTextField(
            controller: _addressController,
            label: 'Address',
            hintText: 'Enter property address',
            maxLines: 3,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inspection Checklist',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          UIHelper.verticalSpace(16.h),
          _buildTextField(
            controller: _checklistController,
            label: 'Checklist / Observations',
            hintText: 'Write inspection findings here',
            maxLines: 6,
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (_activeStep) {
      case 0:
        return _buildStepOne();
      case 1:
        return _buildStepTwo();
      case 2:
        return _buildStepThree();
      default:
        return _buildStepOne();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cFFFFFF,
      appBar: CustomAppBarWidget(
        title: 'New Inspection',
        leadingOnTap: () => NavigationService.goBack,
        showLeadingIcon: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: ActiveStepWidget(activeStep: _activeStep)),
              UIHelper.verticalSpace(28.h),
              _buildCurrentStep(),
              UIHelper.verticalSpace(24.h),
              Row(
                children: [
                  if (_activeStep > 0)
                    Expanded(
                      child: SizedBox(
                        height: 50.h,
                        child: ElevatedButton(
                          onPressed: _previousStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.grey300,
                            foregroundColor: AppColors.c000000,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                    ),
                  if (_activeStep > 0) UIHelper.horizontalSpace(12.w),
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.cFFFFFF,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(_activeStep == 2 ? 'Submit' : 'Continue'),
                      ),
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
