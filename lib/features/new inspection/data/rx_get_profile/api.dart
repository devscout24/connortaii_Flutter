import 'dart:convert';
import 'package:connortaii_app/features/new%20inspection/model/get_health_safety_items_by_inspection_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetHealthSafetyItemsByInspectionApi {
  static final GetHealthSafetyItemsByInspectionApi _singleton =
      GetHealthSafetyItemsByInspectionApi._internal();
  GetHealthSafetyItemsByInspectionApi._internal();
  static GetHealthSafetyItemsByInspectionApi get instance => _singleton;

  Future<GetHealthSafetyItemsByInspectionResponseModel>
  getHealthSafetyItemsByInspectionApi({required int inspectionId}) async {
    try {
      Response response = await getHttp(
        Endpoints.healthSafetyItemsByInspection(inspectionId: inspectionId),
      );

      if (response.statusCode == 200) {
        final data = GetHealthSafetyItemsByInspectionResponseModel.fromRawJson(
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
