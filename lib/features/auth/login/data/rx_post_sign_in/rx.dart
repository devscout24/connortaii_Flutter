// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/features/auth/login/data/rx_post_sign_in/api.dart';
import 'package:connortaii_app/features/auth/login/model/login_response_model.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../helpers/toast.dart';

final class LoginRX extends RxResponseInt<LoginResponseModel> {
  final api = LogInApi.instance;
  bool isEmailUnverified = false;

  LoginRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> logInRX({
    required String email,
    required String password,
  }) async {
    isEmailUnverified = false;
    try {
      LoginResponseModel data = await api.logInApi(
        email: email,
        password: password,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleSuccessWithReturn(LoginResponseModel data) {
    appData.write(kKeyAccessToken, data.data?.token);
    appData.write(kKeyUserID, data.data?.id);
    // appData.write(kKeyEmail, data.data?.email);
    appData.write(kKeyIsLoggedIn, true);
    // appData.write(kKeyUserID, data.data?.id);
    // appData.write(kKeyAssignedClinicianID, data.data?.assignedClinicianId);
    String token = appData.read(kKeyAccessToken);
    DioSingleton.instance.update(token);
    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException && error.response != null) {
      final resData = error.response!.data;
      final statusCode = error.response!.statusCode;
      String message = '';
      if (resData is Map) {
        message = (resData["message"] ?? resData["error"] ?? '').toString();
      }

      final lowerMsg = message.toLowerCase();
      if (statusCode == 422 &&
          (lowerMsg.contains("wasn't verified") ||
              lowerMsg.contains("not verified") ||
              lowerMsg.contains("unverified"))) {
        isEmailUnverified = true;
        log('Email not verified detected: $message');
        dataFetcher.sink.addError(error);
        return false;
      }

      if (message.isNotEmpty) {
        ToastUtil.showShortToast(message);
      } else {
        ToastUtil.showShortToast('Authentication failed');
      }
    } else {
      ToastUtil.showShortToast(error.toString());
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
