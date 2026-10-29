import 'dart:convert';
import 'package:connortaii_app/features/history/model/inspections_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class GetAllInspectionsApi {
  static final GetAllInspectionsApi _singleton = GetAllInspectionsApi._internal();
  GetAllInspectionsApi._internal();
  static GetAllInspectionsApi get instance => _singleton;

  Future<InspectionsResponseModel> getAllInspectionsApi() async {
    try {
      Response response = await getHttp(Endpoints.getAllInspections());

      if (response.statusCode == 200) {
        final data = InspectionsResponseModel.fromRawJson(
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

