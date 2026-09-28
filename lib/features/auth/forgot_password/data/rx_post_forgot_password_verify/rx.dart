// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:developer';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/features/auth/forgot_password/model/forgot_password_verify_response_model.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ForgotPasswordOtpVerifyRx
    extends RxResponseInt<ForgotPasswordVerifyResponseModel> {
  final api = ForgotPasswordVerifyOtpApi.instance;

  ForgotPasswordOtpVerifyRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> forgotPasswordOtpVerifyRx({
    required String email,
    required String otp,
  }) async {
    try {
      ForgotPasswordVerifyResponseModel data = await api
          .forgotPasswordVerifyOtpApi(email: email, otp: otp);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleSuccessWithReturn(ForgotPasswordVerifyResponseModel data) {
    appData.write(kKeyotpVerifyToken, data.user?.resetPasswordToken);
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;

      String message = "Something went wrong";

      if (data is Map<String, dynamic>) {
        final errorMap = data["error"];

        if (errorMap is Map<String, dynamic>) {
          // get first error field
          final firstKey = errorMap.keys.first;
          final firstValue = errorMap[firstKey];

          if (firstValue is List && firstValue.isNotEmpty) {
            message = firstValue[0];
          } else if (firstValue is String) {
            message = firstValue;
          }
        } else if (data["message"] != null) {
          message = data["message"].toString();
        }
      }

      ToastUtil.showShortToast(message);
    } else {
      ToastUtil.showShortToast(error.toString());
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
