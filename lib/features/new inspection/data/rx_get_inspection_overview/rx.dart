// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:connortaii_app/features/new%20inspection/model/get_inspection_overview_response_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetInspectionOverViewRX
    extends RxResponseInt<GetInspectionOverViewResponseModel> {
  final api = GetInspectionOverViewApi.instance;

  GetInspectionOverViewRX({required super.empty, required super.dataFetcher});

  ValueStream get articleSteam => dataFetcher.stream;

  Future<void> getInspectionOverViewRX({required int inspectionId}) async {
    try {
      GetInspectionOverViewResponseModel data = await api.getInspectionOverView(
        inspectionId: inspectionId,
      );
      handleSuccessWithReturn(data);
    } catch (error) {
      return handleErrorWithReturn(error);
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      if (error.response?.statusCode == 422) {
        ToastUtil.showShortToast(error.response!.data["message"]);
      } else {
        // ToastUtil.showShortToast(error.response?.data["message"]);
      }
    }
    log(error.toString());
    dataFetcher.sink.addError(error);
    // throw error;
    return false;
  }
}
