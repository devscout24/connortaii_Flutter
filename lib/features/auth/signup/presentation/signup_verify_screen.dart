import 'dart:async';
import 'package:connortaii_app/assets_helper/app_colors.dart';
import 'package:connortaii_app/common_widget/custom_back_button.dart';
import 'package:connortaii_app/common_widget/custom_button.dart';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/constants/text_font_style.dart';
import 'package:connortaii_app/helpers/all_routes.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/navigation_service.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/helpers/ui_helpers.dart';
import 'package:connortaii_app/networks/api_acess.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupVerifyScreen extends StatefulWidget {
  final String email;
  const SignupVerifyScreen({super.key, required this.email});

  @override
  State<SignupVerifyScreen> createState() => _SignupVerifyScreenState();
}

class _SignupVerifyScreenState extends State<SignupVerifyScreen>
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

    super.dispose();
  }

  bool isLoading = false;
  //reSendCodeRxObj.reSendCodeRx
  Future<void> otpVerifyMethod() async {
    try {
      if (formKey.currentState!.validate()) {
        setState(() {
          isLoading = true;
        });

        await signupEmailVerifyOtpRxObj
            .signupEmailVerifyOtpRx(
              otp: otpController.text,
              email: widget.email,
            )
            .then((value) {
              if (value) {
                setState(() {
                  isLoading = false;
                });
                ToastUtil.showShortToast('Verification Successfull');
                NavigationService.navigateTo(Routes.loginScreen);

                appData.write(kKeyUserEmail, widget.email);
              } else {
                setState(() {
                  isLoading = false;
                });
              }
            });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ToastUtil.showShortToast(e.toString());
    }
  }

  bool isResendLoading = false;

  Future<void> resendOtpMethod() async {
    try {
      {
        setState(() {
          isResendLoading = true;
        });

        await signupResendOtpRxOBJ.signupResendOtpRx(email: widget.email).then((
          value,
        ) {
          if (value) {
            setState(() {
              isResendLoading = false;
            });
          } else {
            setState(() {
              isResendLoading = false;
            });
          }
        });
      }
    } catch (e) {
      setState(() {
        isResendLoading = false;
      });
      ToastUtil.showShortToast(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 52.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              UIHelper.verticalSpace(6.h),
              CustomBackButton(
                onTap: () {
                  NavigationService.goBack;
                },
              ),
              UIHelper.verticalSpace(40.h),
              Text(
                'Enter the OTP Verification',
                style: TextFontStyle.headlinePoppins60026,
              ),
              UIHelper.verticalSpace(8.h),
              Text(
                "we have sent the code to this email ${widget.email}",
                style: TextFontStyle.headlinePoppins50016.copyWith(
                  color: AppColors.grey500,
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
                  fieldWidth: 80.w,
                  activeColor: AppColors.grey200Color,
                  activeFillColor: AppColors.grey200Color,
                  inactiveColor: AppColors.grey200Color,
                  inactiveFillColor: AppColors.grey200Color,
                  selectedColor: AppColors.grey200Color,
                  selectedFillColor: AppColors.grey200Color,
                  borderWidth: 1.w,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              UIHelper.verticalSpace(12.h),
              isLoading
                  ? Center(
                      child: SpinKitCircle(
                        color: AppColors.c000000,
                        size: 60.h,
                      ),
                    )
                  : CustomButton(
                      onTap: () {
                        otpVerifyMethod();
                      },
                      title: 'Verify',
                    ),
              UIHelper.verticalSpace(16.h),
              isResendLoading
                  ? Center(
                      child: SpinKitPianoWave(
                        color: AppColors.c000000,
                        size: 10.h,
                      ),
                    )
                  : Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "I didn't get the code. ",
                          style: TextFontStyle.headlinePoppins50016.copyWith(
                            color: AppColors.grey400,
                          ),
                          children: [
                            TextSpan(
                              text: "Resend" + ' ',
                              style: TextFontStyle.headlinePoppins50016
                                  .copyWith(
                                    color: startTime == 0
                                        ? AppColors.textColor
                                        : AppColors.grey400,
                                    fontWeight: FontWeight.bold,
                                  ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  if (startTime == 0) {
                                    resendOtpMethod();
                                  }
                                },
                            ),
                            TextSpan(
                              text: "in" + ' ',
                              style: TextFontStyle.headlinePoppins50016
                                  .copyWith(color: AppColors.grey400),
                            ),
                            TextSpan(
                              text: '00:$startTime',
                              style: TextFontStyle.headlinePoppins50016
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
