// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:developer';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/features/auth/signup/model/signup_verify_response_model.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class SignupEmailVerifyOtpRx
    extends RxResponseInt<SignupVerifyResponseModel> {
  final api = SignupEmailVerifyOtpApi.instance;

  SignupEmailVerifyOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signupEmailVerifyOtpRx({
    required String email,
    required String otp,
  }) async {
    try {
      SignupVerifyResponseModel data = await api.signupEmailVerifyOtpApi(
        email: email,
        otp: otp,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleSuccessWithReturn(SignupVerifyResponseModel data) {
    // Save token from response
    if (data.data?.token != null) {
      appData.write(kKeyAccessToken, data.data!.token);
    }
    // appData.write(kKeyUserID, data.data?.id);
    // appData.write(kKeyEmail, data.data?.email);
    appData.write(kKeyIsLoggedIn, true);
    // appData.write(kKeyUserID, data.data?.id);
    // appData.write(kKeyAssignedClinicianID, data.data?.assignedClinicianId);
    String? token = appData.read(kKeyAccessToken);
    if (token != null) {
      DioSingleton.instance.update(token);
    }
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;

      if (statusCode == 422 && data != null && data["error"] is Map) {
        final Map errors = data["error"];
        final List<String> messages = [];

        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            messages.add(value[0]);
          }
        });

        if (messages.isNotEmpty) {
          ToastUtil.showShortToast(messages.join('\n'));
        }
      } else if (statusCode == 404) {
        ToastUtil.showShortToast(data?["message"] ?? "Not found");
      } else {
        ToastUtil.showShortToast(
          data?["message"] ?? data?["error"] ?? "Something went wrong",
        );
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
