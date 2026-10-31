import 'dart:developer';
import 'package:connortaii_app/features/history/model/user_reports_response_model.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class GetUserReportsRX
    extends RxResponseInt<UserReportsResponseModel> {
  final api = GetUserReportsApi.instance;

  GetUserReportsRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<void> getUserReportsRX() async {
    try {
      UserReportsResponseModel data = await api.getUserReportsApi();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 422) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
  }
}

