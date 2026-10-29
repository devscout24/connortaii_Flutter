import 'dart:async';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_app_bar_widget.dart';
import 'package:connortaii_app/common_widget/custom_text_form_field.dart';
import 'package:connortaii_app/constants/custom_app_list.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_accessibitlity_button_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_reason_chip_widget.dart';
import 'package:connortaii_app/features/new%20inspection/presentation/widget/build_section_card_widget.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

class InspectionAccessibilityScreen extends StatefulWidget {
  final String title;
  final int id;
  final int? inspectionId;
  const InspectionAccessibilityScreen({
    super.key,
    required this.title,
    required this.id,
    this.inspectionId,
  });

  @override
  State<InspectionAccessibilityScreen> createState() =>
      _InspectionAccessibilityScreenState();
}

class _InspectionAccessibilityScreenState
    extends State<InspectionAccessibilityScreen> {
  bool? isRestricted = false;
  String selectedRestrictionReason = '';
  final TextEditingController restrictionController = TextEditingController();

  final Set<int> expandedCheckpointIds = {};
  final Map<int, _CheckpointFormState> _checkpointStates = {};
  StreamSubscription? _subscription;
  bool isLoading = false;

  final ImagePicker _picker = ImagePicker();

  _CheckpointFormState _getCheckpointState(int itemId) {
    return _checkpointStates.putIfAbsent(itemId, () => _CheckpointFormState());
  }

  void toggleCheckpointExpansion(int itemId) {
    setState(() {
      if (expandedCheckpointIds.contains(itemId)) {
        expandedCheckpointIds.remove(itemId);
      } else {
        expandedCheckpointIds.add(itemId);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getSectionAccessibleRXObj.clean();
    getSectionAccessibleRXObj.getSectionAccessibleRX(id: widget.id);

    _subscription = getSectionAccessibleRXObj.dataFetcher.listen((model) {
      if (!mounted) return;
      final section = model.data;
      if (section == null || section.id != widget.id) return;

      setState(() {
        if (section.accessibilityStatus == 'restricted') {
          isRestricted = true;
          if (section.restrictionReason != null) {
            final reasonStr = section.restrictionReason.toString().trim();
            final matchedKey = restrictionReasonsBackendMap.entries
                .firstWhere(
                  (entry) =>
                      entry.value.toLowerCase() == reasonStr.toLowerCase(),
                  orElse: () => const MapEntry('', ''),
                )
                .key;
            if (matchedKey.isNotEmpty) {
              selectedRestrictionReason = matchedKey;
            }
          }
          if (section.restrictionDescription != null) {
            restrictionController.text =
                section.restrictionDescription.toString();
          }
        } else if (section.accessibilityStatus == 'accessible') {
          isRestricted = false;
        }

        // Pre-fill checkpoints
        if (section.checkpoints != null) {
          for (final cp in section.checkpoints!) {
            final cpId = cp.id ?? cp.order;
            if (cpId == null) continue;
            final formState = _getCheckpointState(cpId);

            if (formState.typeController.text.isEmpty && cp.type != null) {
              formState.typeController.text = cp.type.toString();
            }
            if (formState.observationController.text.isEmpty &&
                cp.observations != null) {
              formState.observationController.text = cp.observations.toString();
            }
            if (formState.levelOfConcern.isEmpty &&
                cp.levelOfConcern != null) {
              final loc = cp.levelOfConcern.toString().toLowerCase();
              if (loc == 'green') {
                formState.levelOfConcern = 'Green';
              } else if (loc == 'orange') {
                formState.levelOfConcern = 'Orange';
              } else if (loc == 'red') {
                formState.levelOfConcern = 'Red';
              } else if (loc == 'na' || loc == 'n/a') {
                formState.levelOfConcern = 'N/A';
              } else {
                formState.levelOfConcern = cp.levelOfConcern.toString();
              }
            }
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    restrictionController.dispose();
    for (final state in _checkpointStates.values) {
      state.dispose();
    }
    super.dispose();
  }

  Future<void> accessibilityRestrictedMethod() async {
    if (isLoading) return;
    if (selectedRestrictionReason.isEmpty) {
      ToastUtil.showShortToast('Please select a restriction reason');
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final reasonBackend =
          restrictionReasonsBackendMap[selectedRestrictionReason] ?? 'other';

      final isSuccess = await addRestrictedAccessibilityRxOBJ
          .addRestrictedAccessibilityRx(
            accessibilityStatus: 'restricted',
            restrictionReason: reasonBackend,
            restrictionDescription: restrictionController.text.trim(),
            id: widget.id,
          );

      if (isSuccess) {
        ToastUtil.showShortToast('Restriction added successfully');
        final inspectionId = widget.inspectionId ??
            getSectionAccessibleRXObj.dataFetcher.valueOrNull?.data?.inspectionId;
        if (inspectionId != null) {
          getInspectionOverViewRXObj.getInspectionOverViewRX(
            inspectionId: inspectionId,
          );
        }
        NavigationService.goBack;
      } else {
        ToastUtil.showShortToast('Restriction added Failed');
      }
    } catch (e) {
      ToastUtil.showShortToast('Error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> accessibilityAccessibleMethod() async {
    if (isLoading) return;

    try {
      setState(() {
        isLoading = true;
      });

      // 1. Update section accessibility status to 'accessible'
      final isSuccess = await addRestrictedAccessibilityRxOBJ
          .addRestrictedAccessibilityRx(
            accessibilityStatus: 'accessible',
            restrictionReason: '',
            restrictionDescription: '',
            id: widget.id,
          );

      if (!isSuccess) {
        ToastUtil.showShortToast('Failed to save section accessibility');
        return;
      }

      // 2. Save any filled checkpoints
      final checkpoints =
          getSectionAccessibleRXObj.dataFetcher.valueOrNull?.data?.checkpoints ??
              [];
      bool hasErrors = false;

      for (final cp in checkpoints) {
        final cpId = cp.id;
        if (cpId == null) continue;

        final formState = _checkpointStates[cpId];
        if (formState == null) continue;

        final typeText = formState.typeController.text.trim();
        final obsText = formState.observationController.text.trim();
        final locText = formState.levelOfConcern.trim();
        final hasPhotos = formState.imageFiles.isNotEmpty;

        // Skip saving this checkpoint if nothing was entered
        if (typeText.isEmpty &&
            obsText.isEmpty &&
            locText.isEmpty &&
            !hasPhotos) {
          continue;
        }

        String loc = locText.toLowerCase();
        if (loc == 'n/a' || loc == 'na') {
          loc = 'na';
        } else if (loc.isEmpty) {
          loc = 'na';
        }

        final cpSaved = await addYesAccessibleRxObj.addYesAccessibleRx(
          type: typeText.isNotEmpty ? typeText : (cp.label ?? 'General'),
          levelOfConcern: loc,
          observations: obsText,
          id: cpId,
          photo: hasPhotos ? formState.imageFiles.first : null,
        );

        if (!cpSaved) {
          hasErrors = true;
        }
      }

      if (hasErrors) {
        ToastUtil.showShortToast('Section saved with some checkpoint warnings');
      } else {
        ToastUtil.showShortToast('Section saved successfully');
      }

      // 3. Refresh overview
      final inspectionId = widget.inspectionId ??
          getSectionAccessibleRXObj.dataFetcher.valueOrNull?.data?.inspectionId;
      if (inspectionId != null) {
        getInspectionOverViewRXObj.getInspectionOverViewRX(
          inspectionId: inspectionId,
        );
      }

      // 4. Return back
      NavigationService.goBack;
    } catch (e) {
      ToastUtil.showShortToast('Error: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

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
                            isSelected: isRestricted == false,
                            isRestrictedButton: false,
                            onTap: () {
                              setState(() {
                                isRestricted = false;
                              });
                            },
                          ),
                          UIHelper.horizontalSpace(8.w),
                          BuildAccessibilityButton(
                            title: 'No, Restricted',
                            isSelected: isRestricted == true,
                            isRestrictedButton: true,
                            onTap: () {
                              setState(() {
                                isRestricted = true;
                              });
                            },
                          ),
                        ],
                      ),
                      if (isRestricted == true) ...[
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
                        UIHelper.verticalSpace(18.h),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: isLoading
                                ? null
                                : () {
                                    accessibilityRestrictedMethod();
                                  },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.c000000,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              child: isLoading
                                  ? SpinKitThreeBounce(
                                      color: AppColors.cFFFFFF,
                                      size: 24.sp,
                                    )
                                  : Text(
                                      'Save Section',
                                      style: TextFontStyle.headlinePoppins60024
                                          .copyWith(color: AppColors.cFFFFFF),
                                    ),
                            ),
                          ),
                        ),
                      ],
                      if (isRestricted == false) ...[
                        UIHelper.verticalSpace(16.h),
                        StreamBuilder(
                          stream: getSectionAccessibleRXObj.dataFetcher,
                          builder: (context, snapshot) {
                            final data = snapshot.data?.data;

                            if (data == null) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.h),
                                child: const Center(
                                  child: SpinKitPulse(
                                    color: AppColors.c000000,
                                    size: 50.0,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Failed to load checkpoints"),
                              );
                            }

                            final checkpoints = data.checkpoints ?? [];
                            if (checkpoints.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Center(
                                  child: Text(
                                    'No checkpoints available for this section.',
                                    style: TextFontStyle.headlinePoppins40014,
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: checkpoints.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final checkPoints = checkpoints[index];
                                final itemId =
                                    checkPoints?.id ??
                                    checkPoints?.order ??
                                    index;
                                final isExpanded = expandedCheckpointIds
                                    .contains(itemId);
                                final checkpointState = _getCheckpointState(
                                  itemId,
                                );

                                return BuildSectionCard(
                                  number: checkPoints?.order ?? 0,
                                  title: checkPoints?.label ?? '',
                                  expanded: isExpanded,
                                  onToggle: () =>
                                      toggleCheckpointExpansion(itemId),
                                  typeController:
                                      checkpointState.typeController,
                                  levelOfConcern:
                                      checkpointState.levelOfConcern,
                                  observationController:
                                      checkpointState.observationController,
                                  imageFileList: checkpointState.imageFiles,
                                  greenOntap: () {
                                    setState(() {
                                      checkpointState.levelOfConcern = 'Green';
                                    });
                                  },
                                  orangeOntap: () {
                                    setState(() {
                                      checkpointState.levelOfConcern = 'Orange';
                                    });
                                  },
                                  redOntap: () {
                                    setState(() {
                                      checkpointState.levelOfConcern = 'Red';
                                    });
                                  },
                                  nAOntap: () {
                                    setState(() {
                                      checkpointState.levelOfConcern = 'N/A';
                                    });
                                  },
                                  imagePickerOntap: () async {
                                    final selectedSource =
                                        await showModalBottomSheet<ImageSource>(
                                          context: context,
                                          backgroundColor: AppColors.cFFFFFF,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20.r),
                                            ),
                                          ),
                                          builder: (context) {
                                            return SafeArea(
                                              child: Padding(
                                                padding: EdgeInsets.all(16.sp),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 48.w,
                                                      height: 4.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.grey300,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100.r,
                                                            ),
                                                      ),
                                                    ),
                                                    UIHelper.verticalSpace(
                                                      16.h,
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons
                                                            .camera_alt_outlined,
                                                        color:
                                                            AppColors.c000000,
                                                      ),
                                                      title: Text(
                                                        'Camera',
                                                        style: TextFontStyle
                                                            .headlinePoppins50016,
                                                      ),
                                                      onTap: () =>
                                                          Navigator.pop(
                                                            context,
                                                            ImageSource.camera,
                                                          ),
                                                    ),
                                                    Divider(
                                                      color: AppColors.grey300,
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons
                                                            .photo_library_outlined,
                                                        color:
                                                            AppColors.c000000,
                                                      ),
                                                      title: Text(
                                                        'Gallery',
                                                        style: TextFontStyle
                                                            .headlinePoppins50016,
                                                      ),
                                                      onTap: () =>
                                                          Navigator.pop(
                                                            context,
                                                            ImageSource.gallery,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );

                                    if (selectedSource == null) return;

                                    try {
                                      if (selectedSource ==
                                          ImageSource.camera) {
                                        final pickedFile = await _picker
                                            .pickImage(
                                              source: ImageSource.camera,
                                              imageQuality: 80,
                                            );

                                        if (pickedFile != null) {
                                          setState(() {
                                            checkpointState.imageFiles.add(
                                              pickedFile,
                                            );
                                          });
                                        }
                                        return;
                                      }

                                      final pickedFiles = await _picker
                                          .pickMultiImage(imageQuality: 80);
                                      if (pickedFiles.isNotEmpty) {
                                        setState(() {
                                          checkpointState.imageFiles.addAll(
                                            pickedFiles,
                                          );
                                        });
                                      }
                                    } catch (e) {
                                      debugPrint(e.toString());
                                    }
                                  },
                                );
                              },
                            );
                          },
                        ),

                        UIHelper.verticalSpace(18.h),
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: isLoading
                                ? null
                                : () {
                                    accessibilityAccessibleMethod();
                                  },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.c000000,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              child: isLoading
                                  ? SpinKitThreeBounce(
                                      color: AppColors.cFFFFFF,
                                      size: 24.sp,
                                    )
                                  : Text(
                                      'Save Section',
                                      style: TextFontStyle.headlinePoppins60024
                                          .copyWith(color: AppColors.cFFFFFF),
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
      ),
    );
  }
}

class _CheckpointFormState {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController observationController = TextEditingController();
  final List<XFile> imageFiles = [];
  String levelOfConcern = '';

  void dispose() {
    typeController.dispose();
    observationController.dispose();
  }
}
