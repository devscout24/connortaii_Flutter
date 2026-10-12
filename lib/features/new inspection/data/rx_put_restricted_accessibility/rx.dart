import 'dart:developer';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class AddRestrictedAccessibilityRx extends RxResponseInt<Map> {
  final api = AddRestrictedAccessibilityApi.instance;

  AddRestrictedAccessibilityRx({
    required super.empty,
    required super.dataFetcher,
  });

  ValueStream get getFileData => dataFetcher.stream;

  Future<bool> addRestrictedAccessibilityRx({
    required String accessibilityStatus,
    required String restrictionReason,
    required String restrictionDescription,
    required int id,
  }) async {
    try {
      final Map data = await api.addRestrictedAccessibilityApi(
        accessibilityStatus: accessibilityStatus,
        restrictionReason: restrictionReason,
        restrictionDescription: restrictionDescription,
        id: id,
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

      String message = 'Something went wrong';

      if (data is Map<String, dynamic>) {
        if (data['error'] is Map && data['error'] != null) {
          final errors = data['error'] as Map;

          final firstKey = errors.keys.first;
          final firstError = errors[firstKey];

          if (firstError is List && firstError.isNotEmpty) {
            message = firstError[0];
          } else if (firstError is String) {
            message = firstError;
          }
        } else if (data['message'] != null) {
          message = data['message'].toString();
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
