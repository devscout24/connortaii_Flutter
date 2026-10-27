// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:developer';
import 'package:connortaii_app/features/auth/forgot_password/model/forgot_password_response_model.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class ForgotPasswordRx
    extends RxResponseInt<ForgotPasswordResponseModel> {
  final api = ForgotPasswordApi.instance;

  ForgotPasswordRx({required super.empty, required super.dataFetcher});

  ValueStream<ForgotPasswordResponseModel> get getFileData =>
      dataFetcher.stream;

  Future<bool> forgotPasswordRx({required String email}) async {
    try {
      ForgotPasswordResponseModel data = await api.forgotPasswordApi(
        email: email,
      );
      handleSuccessWithReturn(data);
      if (data.message != null && data.message!.isNotEmpty) {
        ToastUtil.showShortToast(data.message!);
      }
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    String message = "Something went wrong";
    if (error is DioException) {
      final resData = error.response?.data;
      if (resData is Map<String, dynamic>) {
        final errorMap =
            resData["data"] ?? resData["error"] ?? resData["errors"];
        if (errorMap is Map && errorMap.isNotEmpty) {
          final firstValue = errorMap.values.first;
          if (firstValue is List && firstValue.isNotEmpty) {
            message = firstValue.first.toString();
          } else if (firstValue is String) {
            message = firstValue;
          }
        } else if (resData["message"] != null &&
            resData["message"].toString().isNotEmpty) {
          message = resData["message"].toString();
        }
      } else if (resData is String && resData.isNotEmpty) {
        message = resData;
      }
    } else {
      message = error.toString();
    }

    ToastUtil.showShortToast(message);
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
