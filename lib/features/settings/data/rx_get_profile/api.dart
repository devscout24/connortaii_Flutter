import 'dart:convert';
import 'package:connortaii_app/features/settings/model/profile_details_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetProfileApi {
  static final GetProfileApi _singleton = GetProfileApi._internal();
  GetProfileApi._internal();
  static GetProfileApi get instance => _singleton;

  Future<ProfileDetailsResponseModel> getProfileApi() async {
    try {
      Response response = await getHttp(Endpoints.getUserProfile());

      if (response.statusCode == 200) {
        final data = ProfileDetailsResponseModel.fromRawJson(
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
