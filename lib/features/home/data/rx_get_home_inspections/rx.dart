import 'dart:developer';
import 'package:connortaii_app/features/home/data/rx_get_home_inspections/api.dart';
import 'package:connortaii_app/features/home/model/home_inspections_response_model.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

final class GetHomeInspectionsRX
    extends RxResponseInt<HomeInspectionsResponseModel> {
  final api = GetHomeInspectionsApi.instance;

  GetHomeInspectionsRX({required super.empty, required super.dataFetcher});

  ValueStream<HomeInspectionsResponseModel> get homeDataStream =>
      dataFetcher.stream;

  Future<void> getHomeInspectionsRX() async {
    try {
      HomeInspectionsResponseModel data = await api.getHomeInspectionsApi();
      handleSuccessWithReturn(data);
    } catch (error) {
      handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 422 ||
          error.response?.statusCode == 400 ||
          error.response?.statusCode == 404) {
        final resData = error.response?.data;
        if (resData is Map) {
          final msg = resData["message"] ?? resData["error"];
          if (msg != null) {
            ToastUtil.showShortToast(msg.toString());
          }
        }
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
