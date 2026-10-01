import 'dart:convert';
import 'package:connortaii_app/features/settings/model/get_privacy_policy_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class PrivacyPolicyApi {
  static final PrivacyPolicyApi _singleton = PrivacyPolicyApi._internal();
  PrivacyPolicyApi._internal();
  static PrivacyPolicyApi get instance => _singleton;

  Future<GetPrivacyPolicyResponseModel> privacyPolicyApi() async {
    try {
      Response response = await getHttp(Endpoints.getPrivacyPolicy());

      if (response.statusCode == 200) {
        final data = GetPrivacyPolicyResponseModel.fromRawJson(
          json.encode(response.data),
        );
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
