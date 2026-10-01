import 'dart:convert';
import 'package:connortaii_app/features/settings/model/get_terms_condition_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../../networks/dio/dio.dart';
import '../../../../../../networks/endpoints.dart';
import '../../../../../../networks/exception_handler/data_source.dart';

final class TermsAndConditionsApi {
  static final TermsAndConditionsApi _singleton =
      TermsAndConditionsApi._internal();
  TermsAndConditionsApi._internal();
  static TermsAndConditionsApi get instance => _singleton;

  Future<GetTermsConditionResponseModel> termsAndConditionsApi() async {
    try {
      Response response = await getHttp(Endpoints.getTermsAndConditions());
      if (response.statusCode == 200) {
        final data = GetTermsConditionResponseModel.fromRawJson(
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
