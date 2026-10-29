import 'dart:convert';
import 'package:connortaii_app/features/history/model/user_reports_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class GetUserReportsApi {
  static final GetUserReportsApi _singleton = GetUserReportsApi._internal();
  GetUserReportsApi._internal();
  static GetUserReportsApi get instance => _singleton;

  Future<UserReportsResponseModel> getUserReportsApi() async {
    try {
      Response response = await getHttp(Endpoints.getUserReports());

      if (response.statusCode == 200) {
        final data = UserReportsResponseModel.fromRawJson(
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

