import 'dart:developer';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class GenerateReportRx extends RxResponseInt<Map> {
  final api = GenerateReportApi.instance;
  String? lastErrorMessage;

  GenerateReportRx({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<Map?> generateReportRx({required int inspectionId}) async {
    lastErrorMessage = null;
    try {
      final Map data = await api.generateReportApi(inspectionId: inspectionId);
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      handleErrorWithReturn(error);
      return null;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final data = error.response?.data;
      String message = 'Failed to generate report';
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
          final serverMsg = data['message'].toString();
          if (serverMsg.contains('DomPDF') ||
              serverMsg.contains('Pdf') ||
              serverMsg.contains('Facade')) {
            message =
                'Server error: PDF library (DomPDF) is not installed on the backend server.';
          } else {
            message = serverMsg;
          }
        }
      }
      lastErrorMessage = message;
      ToastUtil.showShortToast(message);
    } else {
      lastErrorMessage = error.toString();
      ToastUtil.showShortToast(error.toString());
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return null;
  }
}

