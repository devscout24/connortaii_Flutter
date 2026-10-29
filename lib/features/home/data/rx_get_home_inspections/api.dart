import 'dart:convert';
import 'package:connortaii_app/features/home/model/home_inspections_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class GetHomeInspectionsApi {
  static final GetHomeInspectionsApi _singleton =
      GetHomeInspectionsApi._internal();
  GetHomeInspectionsApi._internal();
  static GetHomeInspectionsApi get instance => _singleton;

  Future<HomeInspectionsResponseModel> getHomeInspectionsApi() async {
    try {
      Response response = await getHttp(Endpoints.getHomeInspections());

      if (response.statusCode == 200) {
        final data = HomeInspectionsResponseModel.fromRawJson(
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
