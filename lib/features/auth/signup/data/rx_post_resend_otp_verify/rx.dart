// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:developer';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

import 'api.dart';

final class SignupResendOtpRx extends RxResponseInt<Map> {
  final api = SignupResendOtpApi.instance;

  SignupResendOtpRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> signupResendOtpRx({required String email}) async {
    try {
      Map data = await api.signupResendOtpApi(email: email);
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response!.statusCode == 429) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        ToastUtil.showShortToast(error.response!.data["error"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
