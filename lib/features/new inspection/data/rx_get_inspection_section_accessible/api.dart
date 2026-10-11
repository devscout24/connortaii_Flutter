import 'dart:convert';
import 'package:connortaii_app/features/new%20inspection/model/get_section_accessible_response_model.dart';
import 'package:dio/dio.dart';
import '../../../../../networks/dio/dio.dart';
import '../../../../../networks/endpoints.dart';
import '../../../../../networks/exception_handler/data_source.dart';

final class GetSectionAccessibleApi {
  static final GetSectionAccessibleApi _singleton =
      GetSectionAccessibleApi._internal();
  GetSectionAccessibleApi._internal();
  static GetSectionAccessibleApi get instance => _singleton;
  Future<GetSectionAccessibleResponseModel> getSectionAccessible({
    required int id,
  }) async {
    try {
      Response response = await getHttp(Endpoints.getSectionAccessible(id: id));

      if (response.statusCode == 200) {
        final data = GetSectionAccessibleResponseModel.fromRawJson(
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
