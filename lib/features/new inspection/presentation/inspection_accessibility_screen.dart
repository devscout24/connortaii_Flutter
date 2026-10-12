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
  const InspectionAccessibilityScreen({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<InspectionAccessibilityScreen> createState() =>
      _InspectionAccessibilityScreenState();
}

class _InspectionAccessibilityScreenState
    extends State<InspectionAccessibilityScreen> {
  bool? isRestricted;
  String selectedRestrictionReason = '';
  final TextEditingController restrictionController = TextEditingController();
  final TextEditingController roofTypeController = TextEditingController();
  final TextEditingController roofObservationController =
      TextEditingController();
  final TextEditingController overallConditionTypeController =
      TextEditingController();
  final TextEditingController overallConditionObservationController =
      TextEditingController();
  final TextEditingController roofCoveringTypeController =
      TextEditingController();
  final TextEditingController roofCoveringObservationController =
      TextEditingController();
  final TextEditingController gluttersTypeController = TextEditingController();
  final TextEditingController gluttersObservationController =
      TextEditingController();
  final TextEditingController flashingsTypeController = TextEditingController();
  final TextEditingController flashingsObservationController =
      TextEditingController();

  String roofTypeLevelOfConcern = '';
  String overallConditionLevelOfConcern = '';
  String roofCoveringLevelOfConcern = '';
  String gluttersLevelOfConcern = '';
  String flashingsLevelOfConcern = '';

  bool sectionOneExpanded = false;
  bool sectionTwoExpanded = false;
  bool sectionThreeExpanded = false;
  bool sectionFourExpanded = false;
  bool sectionFiveExpanded = false;

  final List<XFile> roofTypeImageFiles = [];
  final List<XFile> overallConditionImageFiles = [];
  final List<XFile> roofCoveringImageFiles = [];
  final List<XFile> guttersImageFiles = [];
  final List<XFile> flashingsImageFiles = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    restrictionController.dispose();
    roofTypeController.dispose();
    roofObservationController.dispose();
    overallConditionTypeController.dispose();
    overallConditionObservationController.dispose();
    roofCoveringTypeController.dispose();
    roofCoveringObservationController.dispose();
    gluttersTypeController.dispose();
    gluttersObservationController.dispose();
    flashingsTypeController.dispose();
    flashingsObservationController.dispose();
    super.dispose();
  }

  Future<void> onImageButtonPressed(List<XFile> targetList) async {
    try {
      final pickedFiles = await _picker.pickMultiImage(imageQuality: 80);
      if (pickedFiles.isNotEmpty) {
        setState(() {
          targetList.addAll(pickedFiles);
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    getSectionAccessibleRXObj.getSectionAccessibleRX(id: widget.id);
    super.initState();
  }

  bool isLoading = false;

  Future<void> accessibilityRestrictedMethod() async {
    // if (!formKey.currentState!.validate()) return;

    try {
      setState(() {
        isLoading = true;
      });

      final isSuccess = await addRestrictedAccessibilityRxOBJ
          .addRestrictedAccessibilityRx(
            accessibilityStatus: 'restricted',
            restrictionReason:
                restrictionReasonsBackendMap[selectedRestrictionReason] ??
                'other',
            restrictionDescription: restrictionController.text,
            id: widget.id,
          );

      if (isSuccess) {
        ToastUtil.showShortToast('Restriction added successfully');
        NavigationService.goBack;
      } else {
        ToastUtil.showShortToast('Restriction added Failed');
      }
    } catch (e) {
      ToastUtil.showShortToast('Error: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
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
                            onTap: () {
                              accessibilityRestrictedMethod();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              decoration: BoxDecoration(
                                color: AppColors.c000000,
                                borderRadius: BorderRadius.circular(40.r),
                              ),
                              child: Text(
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

                            if (snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                data == null) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: const Center(
                                  child: SpinKitPulse(
                                    color: AppColors.c000000,
                                    size: 70.0,
                                  ),
                                ),
                              );
                            }
                            if (snapshot.hasError) {
                              return const Center(child: Text(""));
                            }

                            return ListView.builder(
                              itemCount: data?.checkpoints?.length ?? 0,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final checkPoints = data?.checkpoints?[index];

                                return BuildSectionCard(
                                  number: checkPoints?.order ?? 0,
                                  title: checkPoints?.label ?? '',
                                  expanded: sectionOneExpanded,
                                  onToggle: () => setState(
                                    () => sectionOneExpanded =
                                        !sectionOneExpanded,
                                  ),
                                  typeController: roofTypeController,
                                  levelOfConcern: roofTypeLevelOfConcern,
                                  observationController:
                                      roofObservationController,
                                  imageFileList: roofTypeImageFiles,
                                  grenOntap: () {
                                    setState(() {
                                      roofTypeLevelOfConcern = 'Green';
                                    });
                                  },
                                  orangentap: () {
                                    setState(() {
                                      roofTypeLevelOfConcern = 'Orange';
                                    });
                                  },
                                  redOntap: () {
                                    setState(() {
                                      roofTypeLevelOfConcern = 'Red';
                                    });
                                  },
                                  nAOntap: () {
                                    setState(() {
                                      roofTypeLevelOfConcern = 'N/A';
                                    });
                                  },
                                  imagePickerOntap: () {
                                    onImageButtonPressed(roofTypeImageFiles);
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

     // BuildSectionCard(
                        //   number: 2,
                        //   title: 'Overall Condition',
                        //   expanded: sectionTwoExpanded,
                        //   onToggle: () => setState(
                        //     () => sectionTwoExpanded = !sectionTwoExpanded,
                        //   ),
                        //   typeController: overallConditionTypeController,
                        //   levelOfConcern: overallConditionLevelOfConcern,
                        //   observationController:
                        //       overallConditionObservationController,
                        //   imageFileList: overallConditionImageFiles,
                        //   grenOntap: () {
                        //     setState(() {
                        //       overallConditionLevelOfConcern = 'Green';
                        //     });
                        //   },
                        //   orangentap: () {
                        //     setState(() {
                        //       overallConditionLevelOfConcern = 'Orange';
                        //     });
                        //   },
                        //   redOntap: () {
                        //     setState(() {
                        //       overallConditionLevelOfConcern = 'Red';
                        //     });
                        //   },
                        //   nAOntap: () {
                        //     setState(() {
                        //       overallConditionLevelOfConcern = 'N/A';
                        //     });
                        //   },
                        //   imagePickerOntap: () {
                        //     onImageButtonPressed(overallConditionImageFiles);
                        //   },
                        // ),
                        // BuildSectionCard(
                        //   number: 3,
                        //   title: 'Roof Covering',
                        //   expanded: sectionThreeExpanded,
                        //   onToggle: () => setState(
                        //     () => sectionThreeExpanded = !sectionThreeExpanded,
                        //   ),
                        //   typeController: roofCoveringTypeController,
                        //   levelOfConcern: roofCoveringLevelOfConcern,
                        //   observationController:
                        //       roofCoveringObservationController,
                        //   imageFileList: roofCoveringImageFiles,
                        //   grenOntap: () {
                        //     setState(() {
                        //       roofCoveringLevelOfConcern = 'Green';
                        //     });
                        //   },
                        //   orangentap: () {
                        //     setState(() {
                        //       roofCoveringLevelOfConcern = 'Orange';
                        //     });
                        //   },
                        //   redOntap: () {
                        //     setState(() {
                        //       roofCoveringLevelOfConcern = 'Red';
                        //     });
                        //   },
                        //   nAOntap: () {
                        //     setState(() {
                        //       roofCoveringLevelOfConcern = 'N/A';
                        //     });
                        //   },
                        //   imagePickerOntap: () {
                        //     onImageButtonPressed(roofCoveringImageFiles);
                        //   },
                        // ),
                        // BuildSectionCard(
                        //   number: 4,
                        //   title: 'Gutters & Downpipes',
                        //   expanded: sectionFourExpanded,
                        //   onToggle: () => setState(
                        //     () => sectionFourExpanded = !sectionFourExpanded,
                        //   ),
                        //   typeController: gluttersTypeController,
                        //   levelOfConcern: gluttersLevelOfConcern,
                        //   observationController: gluttersObservationController,
                        //   imageFileList: guttersImageFiles,
                        //   grenOntap: () {
                        //     setState(() {
                        //       gluttersLevelOfConcern = 'Green';
                        //     });
                        //   },
                        //   orangentap: () {
                        //     setState(() {
                        //       gluttersLevelOfConcern = 'Orange';
                        //     });
                        //   },
                        //   redOntap: () {
                        //     setState(() {
                        //       gluttersLevelOfConcern = 'Red';
                        //     });
                        //   },
                        //   nAOntap: () {
                        //     setState(() {
                        //       gluttersLevelOfConcern = 'N/A';
                        //     });
                        //   },
                        //   imagePickerOntap: () {
                        //     onImageButtonPressed(guttersImageFiles);
                        //   },
                        // ),
                        // BuildSectionCard(
                        //   number: 5,
                        //   title: 'Flashings & Penetrations',
                        //   expanded: sectionFiveExpanded,
                        //   onToggle: () => setState(
                        //     () => sectionFiveExpanded = !sectionFiveExpanded,
                        //   ),
                        //   typeController: flashingsTypeController,
                        //   levelOfConcern: flashingsLevelOfConcern,
                        //   observationController: flashingsObservationController,
                        //   imageFileList: flashingsImageFiles,
                        //   grenOntap: () {
                        //     setState(() {
                        //       flashingsLevelOfConcern = 'Green';
                        //     });
                        //   },
                        //   orangentap: () {
                        //     setState(() {
                        //       flashingsLevelOfConcern = 'Orange';
                        //     });
                        //   },
                        //   redOntap: () {
                        //     setState(() {
                        //       flashingsLevelOfConcern = 'Red';
                        //     });
                        //   },
                        //   nAOntap: () {
                        //     setState(() {
                        //       flashingsLevelOfConcern = 'N/A';
                        //     });
                        //   },
                        //   imagePickerOntap: () {
                        //     onImageButtonPressed(flashingsImageFiles);
                        //   },
                        // ),