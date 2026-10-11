// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:connortaii_app/features/new%20inspection/model/get_section_accessible_response_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../helpers/toast.dart';
import '../../../../../networks/rx_base.dart';
import 'api.dart';

final class GetSectionAccessibleRX
    extends RxResponseInt<GetSectionAccessibleResponseModel> {
  final api = GetSectionAccessibleApi.instance;

  GetSectionAccessibleRX({required super.empty, required super.dataFetcher});
  ValueStream get articleSteam => dataFetcher.stream;

  Future<void> getSectionAccessibleRX({required int id}) async {
    try {
      GetSectionAccessibleResponseModel data = await api.getSectionAccessible(
        id: id,
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
