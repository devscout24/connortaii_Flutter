import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/active_step_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_height_safety_card_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_safety_check_card_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/overview_item_list_row_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/step_one_widget.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewInspectionScreen extends StatefulWidget {
  const NewInspectionScreen({super.key});

  @override
  State<NewInspectionScreen> createState() => _NewInspectionScreenState();
}

class _NewInspectionScreenState extends State<NewInspectionScreen> {
  @override
  void initState() {
    super.initState();
  }

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
  String? propertyOwnerPresenceValue;
  final TextEditingController otherPeoplePresenceController =
      TextEditingController();
  String? houseOccupiedValue;
  String? wasPropertyFurnishedValue;
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

  //for height red hazard
  bool isHeightConcernExpanded = false;
  bool isHeightConcernSaved = false;
  bool isHeightRestrictionAccepted = false;

  final TextEditingController heightConcernController = TextEditingController();

  /// Concern states
  final Map<String, bool> concernExpanded = {};
  final Map<String, bool> concernSaved = {};

  final Map<String, TextEditingController> concernControllers = {};

  TextEditingController _getConcernController(String key) {
    if (!concernControllers.containsKey(key)) {
      concernControllers[key] = TextEditingController();
    }

    return concernControllers[key]!;
  }

  @override
  void dispose() {
    heightConcernController.dispose();
    otherPeoplePresenceController.dispose();

    for (final controller in concernControllers.values) {
      controller.dispose();
    }

    super.dispose();
  }

  bool isLoading = false;
  int? _inspectionId;

  /// Map of local item key -> existing health safety response id (from GET)
  final Map<String, int?> _healthSafetyResponseIds = {};

  Future<void> _fetchAndPopulateHealthSafetyItems(int inspectionId) async {
    try {
      await getHealthSafetyItemsByInspectionRXObj
          .getHealthSafetyItemsByInspectionRX(inspectionId: inspectionId);

      final model =
          await getHealthSafetyItemsByInspectionRXObj.articleSteam.first;

      if (model.data != null) {
        for (final datum in model.data!) {
          final int? healthItemId = datum.healthSafetyItemId ?? datum.item?.id;
          if (healthItemId == null) continue;

          final check = _healthSafetyChecks.firstWhere(
            (item) => (item['id'] as int) == healthItemId,
            orElse: () => {},
          );

          if (check.isEmpty) continue;

          final key = check['key'] as String;

          // store response id for updates
          _healthSafetyResponseIds[key] = datum.id;

          // populate UI state
          final bool checked = datum.isChecked ?? false;
          final bool hasConcern = datum.hasConcern ?? false;
          final String? details = datum.concernDetails;

          setState(() {
            switch (key) {
              case 'identifiable':
                isIdentifiableChecked = checked;
                break;
              case 'phone_tablet':
                isPhoneTabletChecked = checked;
                break;
              case 'tools':
                isToolsChecked = checked;
                break;
              case 'ppe':
                isPPEChecked = checked;
                break;
              case 'property_occupants':
                isPropertyOccupantsChecked = checked;
                break;
              case 'height':
                isHeightChecked = checked;
                isHeightConcernSaved = hasConcern;
                if (details != null) heightConcernController.text = details;
                break;
              case 'electricity':
                isElectricityChecked = checked;
                break;
              case 'slips_trips_falls':
                isSlipTripFallsChecked = checked;
                break;
              case 'chemicals':
                isChemicalsChecked = checked;
                break;
              default:
                break;
            }

            if (key != 'height') {
              concernSaved[key] = hasConcern;
              if (details != null) _getConcernController(key).text = details;
            }
          });
        }
      }
    } catch (e) {
      // ignore — leave defaults in place
    }
  }

  Map<String, dynamic> _extractInspectionId(Map<dynamic, dynamic> response) {
    final payload = response['data'];
    if (payload is Map) {
      final id =
          payload['id'] ?? payload['inspection_id'] ?? payload['inspectionId'];
      if (id != null) {
        return {'id': id};
      }
    }

    final id =
        response['id'] ?? response['inspection_id'] ?? response['inspectionId'];
    if (id != null) {
      return {'id': id};
    }

    return {};
  }

  final List<Map<String, dynamic>> _healthSafetyChecks = [
    {'id': 1, 'key': 'identifiable', 'title': 'Identifiable'},
    {'id': 2, 'key': 'phone_tablet', 'title': 'Phone / Tablet'},
    {'id': 3, 'key': 'tools', 'title': 'Tools'},
    {'id': 4, 'key': 'ppe', 'title': 'PPE'},
    {'id': 5, 'key': 'property_occupants', 'title': 'Property Occupants'},
    {'id': 6, 'key': 'height', 'title': 'Height'},
    {'id': 7, 'key': 'electricity', 'title': 'Electricity'},
    {'id': 8, 'key': 'slips_trips_falls', 'title': 'Slips, Trips & Falls'},
    {'id': 9, 'key': 'chemicals', 'title': 'Chemicals / Hazardous Substances'},
  ];

  int get _completedHealthSafetyChecks => [
    isIdentifiableChecked,
    isPhoneTabletChecked,
    isToolsChecked,
    isPPEChecked,
    isPropertyOccupantsChecked,
    isHeightChecked,
    isElectricityChecked,
    isSlipTripFallsChecked,
    isChemicalsChecked,
  ].where((value) => value).length;

  Map<String, dynamic> _getHealthSafetyItemByKey(String key) {
    return _healthSafetyChecks.firstWhere(
      (item) => item['key'] == key,
      orElse: () => {'id': 0, 'key': key, 'title': key},
    );
  }

  List<Map<String, dynamic>> _buildHealthSafetyPayloads() {
    return [
      {
        'key': 'identifiable',
        'isChecked': isIdentifiableChecked,
        'hasConcern': concernSaved['identifiable'] ?? false,
        'concernDetails': _getConcernController('identifiable').text.trim(),
      },
      {
        'key': 'phone_tablet',
        'isChecked': isPhoneTabletChecked,
        'hasConcern': concernSaved['phone_tablet'] ?? false,
        'concernDetails': _getConcernController('phone_tablet').text.trim(),
      },
      {
        'key': 'tools',
        'isChecked': isToolsChecked,
        'hasConcern': concernSaved['tools'] ?? false,
        'concernDetails': _getConcernController('tools').text.trim(),
      },
      {
        'key': 'ppe',
        'isChecked': isPPEChecked,
        'hasConcern': concernSaved['ppe'] ?? false,
        'concernDetails': _getConcernController('ppe').text.trim(),
      },
      {
        'key': 'property_occupants',
        'isChecked': isPropertyOccupantsChecked,
        'hasConcern': concernSaved['property_occupants'] ?? false,
        'concernDetails': _getConcernController(
          'property_occupants',
        ).text.trim(),
      },
      {
        'key': 'height',
        'isChecked': isHeightChecked,
        'hasConcern': isHeightConcernSaved,
        'concernDetails': heightConcernController.text.trim(),
      },
      {
        'key': 'electricity',
        'isChecked': isElectricityChecked,
        'hasConcern': concernSaved['electricity'] ?? false,
        'concernDetails': _getConcernController('electricity').text.trim(),
      },
      {
        'key': 'slips_trips_falls',
        'isChecked': isSlipTripFallsChecked,
        'hasConcern': concernSaved['slips_trips_falls'] ?? false,
        'concernDetails': _getConcernController(
          'slips_trips_falls',
        ).text.trim(),
      },
      {
        'key': 'chemicals',
        'isChecked': isChemicalsChecked,
        'hasConcern': concernSaved['chemicals'] ?? false,
        'concernDetails': _getConcernController('chemicals').text.trim(),
      },
    ];
  }

  Future<void> _submitHealthSafetyChecks() async {
    if (_inspectionId == null) {
      ToastUtil.showShortToast(
        'Inspection is not created yet. Please complete step 1 first.',
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final checks = _buildHealthSafetyPayloads();

      for (final check in checks) {
        final item = _getHealthSafetyItemByKey(check['key'] as String);
        final responseId = _healthSafetyResponseIds[check['key'] as String];
        final success = await addHealthSafetyCheckRxOBJ.addHealthSafetyCheckRx(
          inspectionId: _inspectionId!,
          healthSafetyItemId: (item['id'] as int?) ?? 0,
          isChecked: check['isChecked'] as bool,
          hasConcern: check['hasConcern'] as bool,
          concernDetails: (check['concernDetails'] as String?) ?? '',
          responseId: responseId,
        );

        if (!success) {
          return;
        }
      }

      ToastUtil.showShortToast('Health & safety checks saved successfully');
      if (_activeStep < 2) {
        setState(() => _activeStep++);
      } else {
        NavigationService.navigateTo(Routes.reportGeneratedScreen);
      }
    } catch (e) {
      ToastUtil.showShortToast('Error: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _submitStepOne() async {
    if (!formKey.currentState!.validate()) return;

    try {
      setState(() => isLoading = true);

      final responseData = await storeInspectionDetailsRxOBJ
          .storeInspectionDetailsRx(
            inspectorName: inspectorNameController.text.trim(),
            email: emailController.text.trim(),
            mobileNumber: mobileController.text.trim(),
            propertyAddress: addressController.text.trim(),
            propertyName: propertyNameController.text.trim(),
            inspectionDate: inspectionDateController.text.trim(),
            propertyOwnerName: propertyOwnerNameController.text.trim(),
            propertyOwnerPresence:
                propertyOwnerPresenceValue?.toLowerCase() == 'yes',
            otherPeoplePresence: otherPeoplePresenceController.text.trim(),
            houseOccupied: houseOccupiedValue?.toLowerCase() == 'yes',
            propertyFurnished:
                wasPropertyFurnishedValue?.toLowerCase() == 'yes',
            buildingType: buildingTypeController.text.trim(),
            statusOfUtilities: statusOfUtilitiesController.text.trim(),
            weatherDuringInspection: weatherDuringInspectionController.text
                .trim(),
          );

      final extracted = _extractInspectionId(responseData);
      if (extracted['id'] != null) {
        _inspectionId = int.tryParse(extracted['id'].toString());
      }

      if (_inspectionId != null) {
        ToastUtil.showShortToast('Inspection details saved successfully');
        // fetch existing health & safety responses for this inspection
        _fetchAndPopulateHealthSafetyItems(_inspectionId!);
        if (_activeStep < 2) {
          setState(() => _activeStep++);
        } else {
          NavigationService.navigateTo(Routes.reportGeneratedScreen);
        }
        return;
      }

      ToastUtil.showShortToast('Inspection created but no ID was returned.');
    } catch (e) {
      ToastUtil.showShortToast('Error: ${e.toString()}');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _nextStep() {
    if (_activeStep == 0) {
      _submitStepOne();
      return;
    }

    if (_activeStep == 1) {
      _submitHealthSafetyChecks();
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
      'inspectionName': inspectorNameController.text.trim(),
      'inspectorEmail': emailController.text.trim(),
      'address': addressController.text.trim(),
      'mobileNumber': mobileController.text.trim(),
      'propertyName': propertyNameController.text.trim(),
      'propertyOwnerPresence':
          propertyOwnerPresenceValue?.toLowerCase() == 'yes' ? true : false,
      'houseOccupied': houseOccupiedValue?.toLowerCase() == 'yes'
          ? true
          : false,
      'wasPropertyFurnished': wasPropertyFurnishedValue?.toLowerCase() == 'yes'
          ? true
          : false,
    };

    debugPrint('Inspection payload: $payload');
    NavigationService.navigateTo(Routes.reportGeneratedScreen);
  }

  Widget _buildStepThree() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey200Color,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.grey300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Inspection Overview',
              style: TextFontStyle.headlinePoppins60018,
            ),
          ),
          UIHelper.verticalSpace(4.h),
          Center(
            child: Text(
              'A clear summary of key findings across the property.',
              style: TextFontStyle.headlinePoppins40012.copyWith(
                color: AppColors.grey500,
              ),
            ),
          ),
          UIHelper.verticalSpace(16.h),
          UIHelper.customDivider(color: AppColors.grey300),
          UIHelper.verticalSpace(16.h),
          Text(
            '${_completedHealthSafetyChecks} of ${_healthSafetyChecks.length} checks completed',
            style: TextFontStyle.headlinePoppins50014,
          ),
          UIHelper.verticalSpace(8.h),
          LinearProgressIndicator(
            minHeight: 6.h,
            backgroundColor: AppColors.cFFFFFF,
            color: AppColors.c000000,
            borderRadius: BorderRadius.circular(16.r),
            value: _completedHealthSafetyChecks / _healthSafetyChecks.length,
          ),
          UIHelper.verticalSpace(16.h),
          OverviewItemListRowWidget(
            index: '1',
            title: 'Exterior Roof',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Exterior Roof'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '2',
            title: 'Roof Space',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Roof Space'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '3',
            title: 'External Wall Cladding',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'External Wall Cladding'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '4',
            title: 'Foundation & Subfloor',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Foundation & Subfloor'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '5',
            title: 'Plumbing System',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Plumbing System'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '6',
            title: 'Electrical System',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Electrical System'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '7',
            title: 'Weather Tightness',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Weather Tightness'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '8',
            title: 'Site Improvements',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Site Improvements'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '9',
            title: 'Pest & Potential Hazards',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Pest & Potential Hazards'},
              );
            },
          ),
          UIHelper.verticalSpace(12.h),
          OverviewItemListRowWidget(
            index: '10',
            title: 'Interior Elements',
            status: 'Not Started',
            onTap: () {
              NavigationService.navigateToWithArgs(
                Routes.inspectionStartedScreen,
                {'title': 'Interior Elements'},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildCurrentStepWidget() {
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
          propertyOwnerPresenceValue: propertyOwnerPresenceValue,
          onPropertyOwnerPresenceChanged: (value) =>
              setState(() => propertyOwnerPresenceValue = value),
          otherPeoplePresenceController: otherPeoplePresenceController,
          houseOccupiedValue: houseOccupiedValue,
          onHouseOccupiedChanged: (value) =>
              setState(() => houseOccupiedValue = value),
          wasPropertyFurnishedValue: wasPropertyFurnishedValue,
          onWasPropertyFurnishedChanged: (value) =>
              setState(() => wasPropertyFurnishedValue = value),
          buildingTypeController: buildingTypeController,
          statusOfUtilitiesController: statusOfUtilitiesController,
          weatherDuringInspectionController: weatherDuringInspectionController,
        );
      case 1:
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
              UIHelper.verticalSpace(4.h),
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
                '${_completedHealthSafetyChecks} of ${_healthSafetyChecks.length} checks completed',
                style: TextFontStyle.headlinePoppins50014,
              ),
              UIHelper.verticalSpace(8.h),
              LinearProgressIndicator(
                minHeight: 6.h,
                backgroundColor: AppColors.cFFFFFF,
                color: AppColors.c000000,
                borderRadius: BorderRadius.circular(16.r),
                value:
                    _completedHealthSafetyChecks / _healthSafetyChecks.length,
              ),
              UIHelper.verticalSpace(16.h),
              // 1
              BuildSafetyCheckCardWidget(
                key: const ValueKey('identifiable'),
                title: 'Identifiable',
                description: 'I have my uniform and name badge on.',
                isChecked: isIdentifiableChecked,
                isExpanded: concernExpanded['identifiable'] ?? false,
                isSaved: concernSaved['identifiable'] ?? false,
                controller: _getConcernController('identifiable'),
                onCheckChanged: (value) {
                  setState(() {
                    isIdentifiableChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['identifiable'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['identifiable'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['identifiable'] = true;
                    concernExpanded['identifiable'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['identifiable'] = false;
                    concernExpanded['identifiable'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['identifiable'] = false;
                    concernExpanded['identifiable'] = false;
                    _getConcernController('identifiable').clear();
                  });
                },
              ),
              UIHelper.verticalSpace(12.h),
              // 2
              BuildSafetyCheckCardWidget(
                key: const ValueKey('phone_tablet'),
                title: 'Phone / Tablet',
                description: 'My iPad and phone are working and charged.',
                isChecked: isPhoneTabletChecked,
                isExpanded: concernExpanded['phone_tablet'] ?? false,
                isSaved: concernSaved['phone_tablet'] ?? false,
                controller: _getConcernController('phone_tablet'),
                onCheckChanged: (value) {
                  setState(() {
                    isPhoneTabletChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['phone_tablet'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['phone_tablet'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['phone_tablet'] = true;
                    concernExpanded['phone_tablet'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['phone_tablet'] = false;
                    concernExpanded['phone_tablet'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['phone_tablet'] = false;
                    concernExpanded['phone_tablet'] = false;
                    _getConcernController('phone_tablet').clear();
                  });
                },
              ),
              UIHelper.verticalSpace(12.h),
              // 3
              BuildSafetyCheckCardWidget(
                key: const ValueKey('tools'),
                title: 'Tools',
                description: 'My tools are available and in working condition.',
                isChecked: isToolsChecked,
                isExpanded: concernExpanded['tools'] ?? false,
                isSaved: concernSaved['tools'] ?? false,
                controller: _getConcernController('tools'),
                onCheckChanged: (value) {
                  setState(() {
                    isToolsChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['tools'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['tools'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['tools'] = true;
                    concernExpanded['tools'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['tools'] = false;
                    concernExpanded['tools'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['tools'] = false;
                    concernExpanded['tools'] = false;
                    _getConcernController('tools').clear();
                  });
                },
              ),
              UIHelper.verticalSpace(12.h),
              // 4
              BuildSafetyCheckCardWidget(
                key: const ValueKey('ppe'),
                title: 'PPE',
                description: 'Required PPE is available and ready to use.',
                isChecked: isPPEChecked,
                isExpanded: concernExpanded['ppe'] ?? false,
                isSaved: concernSaved['ppe'] ?? false,
                controller: _getConcernController('ppe'),
                onCheckChanged: (value) {
                  setState(() {
                    isPPEChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['ppe'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['ppe'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['ppe'] = true;
                    concernExpanded['ppe'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['ppe'] = false;
                    concernExpanded['ppe'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['ppe'] = false;
                    concernExpanded['ppe'] = false;
                    _getConcernController('ppe').clear();
                  });
                },
              ),

              UIHelper.verticalSpace(12.h),

              // 5
              BuildSafetyCheckCardWidget(
                key: const ValueKey('property_occupants'),
                title: 'Property Occupants',
                description:
                    'I am aware of the occupants and have considered their presence.',
                isChecked: isPropertyOccupantsChecked,
                isExpanded: concernExpanded['property_occupants'] ?? false,
                isSaved: concernSaved['property_occupants'] ?? false,
                controller: _getConcernController('property_occupants'),
                onCheckChanged: (value) {
                  setState(() {
                    isPropertyOccupantsChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['property_occupants'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['property_occupants'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['property_occupants'] = true;
                    concernExpanded['property_occupants'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['property_occupants'] = false;
                    concernExpanded['property_occupants'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['property_occupants'] = false;
                    concernExpanded['property_occupants'] = false;
                    _getConcernController('property_occupants').clear();
                  });
                },
              ),

              UIHelper.verticalSpace(12.h),

              // 6
              BuildHeightSafetyCardWidget(
                isChecked: isHeightChecked,
                isExpanded: isHeightConcernExpanded,
                isSaved: isHeightConcernSaved,
                isRestrictionAccepted: isHeightRestrictionAccepted,
                controller: heightConcernController,
                onCheckChanged: (value) {
                  setState(() {
                    isHeightChecked = value ?? false;
                  });
                },
                onReportConcern: () {
                  setState(() {
                    isHeightConcernExpanded = true;
                  });
                },
                onCancelConcern: () {
                  setState(() {
                    isHeightConcernExpanded = false;
                  });
                },
                onSaveConcern: () {
                  setState(() {
                    isHeightConcernSaved = true;
                    isHeightConcernExpanded = false;
                  });
                },
                onEditConcern: () {
                  setState(() {
                    isHeightConcernSaved = false;
                    isHeightConcernExpanded = true;
                  });
                },
                onClearConcern: () {
                  setState(() {
                    isHeightConcernSaved = false;
                    isHeightConcernExpanded = false;
                    isHeightRestrictionAccepted = false;
                    heightConcernController.clear();
                  });
                },
                onStopInspection: () {
                  NavigationService.navigateTo(Routes.navigationScreen);
                },
                onContinueRestriction: () {
                  setState(() {
                    isHeightRestrictionAccepted = true;
                  });
                },
                onChangeRestriction: () {
                  setState(() {
                    isHeightRestrictionAccepted = false;
                  });
                },
              ),
              UIHelper.verticalSpace(12.h),

              // 7
              BuildSafetyCheckCardWidget(
                key: const ValueKey('electricity'),
                title: 'Electricity',
                description:
                    'Potential electrical hazards have been considered.',
                isChecked: isElectricityChecked,
                isExpanded: concernExpanded['electricity'] ?? false,
                isSaved: concernSaved['electricity'] ?? false,
                controller: _getConcernController('electricity'),
                onCheckChanged: (value) {
                  setState(() {
                    isElectricityChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['electricity'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['electricity'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['electricity'] = true;
                    concernExpanded['electricity'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['electricity'] = false;
                    concernExpanded['electricity'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['electricity'] = false;
                    concernExpanded['electricity'] = false;
                    _getConcernController('electricity').clear();
                  });
                },
              ),

              UIHelper.verticalSpace(12.h),

              // 8
              BuildSafetyCheckCardWidget(
                key: const ValueKey('slips_trips_falls'),
                title: 'Slips, Trips & Falls',
                description:
                    'Potential slip, trip or fall hazards have been considered.',
                isChecked: isSlipTripFallsChecked,
                isExpanded: concernExpanded['slips_trips_falls'] ?? false,
                isSaved: concernSaved['slips_trips_falls'] ?? false,
                controller: _getConcernController('slips_trips_falls'),
                onCheckChanged: (value) {
                  setState(() {
                    isSlipTripFallsChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['slips_trips_falls'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['slips_trips_falls'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['slips_trips_falls'] = true;
                    concernExpanded['slips_trips_falls'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['slips_trips_falls'] = false;
                    concernExpanded['slips_trips_falls'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['slips_trips_falls'] = false;
                    concernExpanded['slips_trips_falls'] = false;
                    _getConcernController('slips_trips_falls').clear();
                  });
                },
              ),

              UIHelper.verticalSpace(12.h),

              // 9
              BuildSafetyCheckCardWidget(
                key: const ValueKey('chemicals'),
                title: 'Chemicals / Hazardous Substances',
                description:
                    'Potential chemical or hazardous substance risks have been considered.',
                isChecked: isChemicalsChecked,
                isExpanded: concernExpanded['chemicals'] ?? false,
                isSaved: concernSaved['chemicals'] ?? false,
                controller: _getConcernController('chemicals'),
                onCheckChanged: (value) {
                  setState(() {
                    isChemicalsChecked = value ?? false;
                  });
                },
                onToggleExpanded: () {
                  setState(() {
                    concernExpanded['chemicals'] = true;
                  });
                },
                onCancel: () {
                  setState(() {
                    concernExpanded['chemicals'] = false;
                  });
                },
                onSave: () {
                  setState(() {
                    concernSaved['chemicals'] = true;
                    concernExpanded['chemicals'] = false;
                  });
                },
                onEdit: () {
                  setState(() {
                    concernSaved['chemicals'] = false;
                    concernExpanded['chemicals'] = true;
                  });
                },
                onClear: () {
                  setState(() {
                    concernSaved['chemicals'] = false;
                    concernExpanded['chemicals'] = false;
                    _getConcernController('chemicals').clear();
                  });
                },
              ),
            ],
          ),
        );
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
          propertyOwnerPresenceValue: propertyOwnerPresenceValue,
          onPropertyOwnerPresenceChanged: (value) =>
              setState(() => propertyOwnerPresenceValue = value),
          otherPeoplePresenceController: otherPeoplePresenceController,
          houseOccupiedValue: houseOccupiedValue,
          onHouseOccupiedChanged: (value) =>
              setState(() => houseOccupiedValue = value),
          wasPropertyFurnishedValue: wasPropertyFurnishedValue,
          onWasPropertyFurnishedChanged: (value) =>
              setState(() => wasPropertyFurnishedValue = value),
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    buildCurrentStepWidget(),
                    UIHelper.verticalSpace(24.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            onTap: () {
                              _nextStep();
                            },
                            title: _activeStep == 2
                                ? 'Review Inspection'
                                : 'Continue',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
