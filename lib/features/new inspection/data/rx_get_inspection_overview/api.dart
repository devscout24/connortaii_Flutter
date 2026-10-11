import 'dart:convert';
import 'package:connortaii_app/features/new%20inspection/model/get_inspection_overview_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetInspectionOverViewApi {
  static final GetInspectionOverViewApi _singleton =
      GetInspectionOverViewApi._internal();
  GetInspectionOverViewApi._internal();
  static GetInspectionOverViewApi get instance => _singleton;
  Future<GetInspectionOverViewResponseModel> getInspectionOverView({
    required int inspectionId,
  }) async {
    try {
      Response response = await getHttp(
        Endpoints.getInspectionOverView(inspectionId: inspectionId),
      );

      if (response.statusCode == 200) {
        final data = GetInspectionOverViewResponseModel.fromRawJson(
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
