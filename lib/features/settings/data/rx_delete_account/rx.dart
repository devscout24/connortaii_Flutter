// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../../helpers/toast.dart';
import '../../../../../../../networks/rx_base.dart';
import 'api.dart';

final class DeleteAccountRx extends RxResponseInt<Map> {
  final api = DeleteAccountApi.instance;

  DeleteAccountRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> deleteAccountRx() async {
    try {
      Map data = await api.deleteAccountApi();
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final resData = error.response?.data;
      if (resData is Map) {
        final msg = resData["message"] ?? resData["error"];
        if (msg != null) {
          ToastUtil.showShortToast(msg.toString());
        }
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
