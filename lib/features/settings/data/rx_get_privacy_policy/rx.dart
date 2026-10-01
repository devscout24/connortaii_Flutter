// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:connortaii_app/features/settings/model/get_privacy_policy_response_model.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../../helpers/toast.dart';
import '../../../../../../networks/rx_base.dart';
import 'api.dart';

final class PrivacyPolicyRX
    extends RxResponseInt<GetPrivacyPolicyResponseModel> {
  final api = PrivacyPolicyApi.instance;

  PrivacyPolicyRX({required super.empty, required super.dataFetcher});

  ValueStream get articleSteam => dataFetcher.stream;

  Future<void> privacyPolicyRX() async {
    try {
      GetPrivacyPolicyResponseModel data = await api.privacyPolicyApi();
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
