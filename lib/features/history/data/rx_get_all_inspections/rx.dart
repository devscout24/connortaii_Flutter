import 'dart:developer';
import 'package:connortaii_app/features/history/model/inspections_response_model.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'api.dart';

final class GetAllInspectionsRX
    extends RxResponseInt<InspectionsResponseModel> {
  final api = GetAllInspectionsApi.instance;

  GetAllInspectionsRX({required super.empty, required super.dataFetcher});

  ValueStream get getFileData => dataFetcher.stream;

  Future<InspectionsResponseModel> getAllInspectionsRX() async {
    try {
      InspectionsResponseModel data = await api.getAllInspectionsApi();
      handleSuccessWithReturn(data);
      return data;
    } catch (error) {
      return handleErrorWithReturn(error);
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
    return false;
  }
}

