import 'dart:async';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordVerifyScreen extends StatefulWidget {
  final String email;

  const ForgotPasswordVerifyScreen({super.key, required this.email});

  @override
  State<ForgotPasswordVerifyScreen> createState() =>
      _ForgotPasswordVerifyScreenState();
}

class _ForgotPasswordVerifyScreenState extends State<ForgotPasswordVerifyScreen>
    with TickerProviderStateMixin {
  TextEditingController otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  late AnimationController _bottomSheetController;

  late int startTime;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTime = 30;
    startTimer();
    _bottomSheetController = BottomSheet.createAnimationController(this);
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTime == 0) {
        timer.cancel();
      } else {
        setState(() {
          startTime--;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();

    _bottomSheetController.dispose();
    otpController.dispose();

    super.dispose();
  }

  bool isLoading = false;

  //reSendCodeRxObj.reSendCodeRx
  // Future<void> otpVerifyMethod() async {
  //   try {
  //     if (formKey.currentState!.validate()) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       await forgotPasswordOtpVerifyRxObj
  //           .forgotPasswordOtpVerifyRx(
  //             otp: otpController.text,
  //             email: widget.email,
  //           )
  //           .then((value) {
  //             if (value) {
  //               setState(() {
  //                 isLoading = false;
  //               });
  //               NavigationService.navigateTo(Routes.forgotUpdatePassword);
  //             } else {
  //               setState(() {
  //                 isLoading = false;
  //               });
  //             }
  //           });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoading = false;
  //     });
  //     ToastUtil.showShortToast(e.toString());
  //   }
  // }

  bool isResendLoading = false;

  // Future<void> resendOtpMethod() async {
  //   try {
  //     {
  //       setState(() {
  //         isResendLoading = true;
  //       });

  //       await forgotPasswordResendOtpRxOBJ
  //           .forgotPasswordResendOtpRx(email: widget.email)
  //           .then((value) {
  //             if (value) {
  //               setState(() {
  //                 isResendLoading = false;
  //               });
  //             } else {
  //               setState(() {
  //                 isResendLoading = false;
  //               });
  //             }
  //           });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isResendLoading = false;
  //     });
  //     ToastUtil.showShortToast(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 48.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(40.h),
              Center(
                child: Text(
                  'Check Your Email',
                  style: TextFontStyle.headlinePoppins60024.copyWith(
                    color: AppColors.titleTextColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              UIHelper.verticalSpace(8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Center(
                  child: Text(
                    "Please enter the 4 Digit Code",
                    style: TextFontStyle.headlinePoppins40016.copyWith(
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              UIHelper.verticalSpace(20.h),
              PinCodeTextField(
                appContext: context,
                length: 4,
                controller: otpController,
                keyboardType: TextInputType.number,
                backgroundColor: Colors.transparent,
                textStyle: TextFontStyle.headlinePoppins70016.copyWith(
                  color: AppColors.grey700,
                ),
                enableActiveFill: true,
                useExternalAutoFillGroup: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  // fieldOuterPadding: EdgeInsets.symmetric(
                  //   horizontal: 12.w,
                  //   vertical: 12.h,
                  // ),
                  fieldHeight: 55.h,
                  fieldWidth: 90.w,
                  activeColor: AppColors.lightGreenish,
                  activeFillColor: AppColors.lightGreenish,
                  inactiveColor: AppColors.lightGreenish,
                  inactiveFillColor: AppColors.lightGreenish,
                  selectedColor: AppColors.lightGreenish,
                  selectedFillColor: AppColors.lightGreenish,
                  borderWidth: 1.w,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: AppColors.buttonbgColor,
                        size: 60.h,
                      ),
                    )
                  : CustomButton(
                      onTap: () {
                        NavigationService.navigateTo(
                          Routes.forgotUpdatePasswordScreen,
                        );
                        // otpVerifyMethod();
                      },
                      title: 'Submit',
                    ),
              UIHelper.verticalSpace(4.h),
              CustomButton(
                onTap: () {
                  NavigationService.goBack;
                },
                title: 'Cancel',
                fillColor: Colors.transparent,
                textColor: AppColors.secondaryButtonBg,
              ),
              UIHelper.verticalSpace(6.h),
              isResendLoading
                  ? Center(
                      child: SpinKitPianoWave(
                        color: AppColors.textColor,
                        size: 10.h,
                      ),
                    )
                  : Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Resend",
                          style: TextFontStyle.headlinePoppins40014grey
                              .copyWith(
                                color: startTime == 0
                                    ? AppColors.textColor
                                    : AppColors.grey400,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (startTime == 0) {
                                // resendOtpMethod();
                              }
                            },
                          children: [
                            TextSpan(
                              text: " in ",
                              style: TextFontStyle.headlinePoppins40014grey
                                  .copyWith(color: AppColors.grey400),
                            ),
                            TextSpan(
                              text: '00:$startTime',
                              style: TextFontStyle.headlinePoppins40014grey
                                  .copyWith(color: AppColors.grey400),
                            ),
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
