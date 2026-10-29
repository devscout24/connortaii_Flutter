import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class GenerateReportApi {
  static final GenerateReportApi _singleton = GenerateReportApi._internal();
  GenerateReportApi._internal();
  static GenerateReportApi get instance => _singleton;

  Future<Map> generateReportApi({required int inspectionId}) async {
    try {
      Response response = await postHttp(
        Endpoints.generateReport(inspectionId: inspectionId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(json.encode(response.data));
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}

