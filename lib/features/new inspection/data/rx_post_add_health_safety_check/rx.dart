// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:developer';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class AddHealthSafetyCheckRx extends RxResponseInt<Map> {
  final api = AddHealthSafetyCheckApi.instance;

  AddHealthSafetyCheckRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> addHealthSafetyCheckRx({
    required bool isChecked,
    required bool hasConcern,
    required String concernDetails,
  }) async {
    try {
      Map data = await api.addHealthSafetyCheckApi(
        isChecked: isChecked,
        hasConcern: hasConcern,
        concernDetails: concernDetails,
      );
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
      final data = error.response?.data;

      String message = "Something went wrong";

      if (data is Map<String, dynamic>) {
        if (data["error"] is Map && data["error"] != null) {
          final errors = data["error"] as Map;

          final firstKey = errors.keys.first;
          final firstError = errors[firstKey];

          if (firstError is List && firstError.isNotEmpty) {
            message = firstError[0];
          } else if (firstError is String) {
            message = firstError;
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
