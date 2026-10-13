import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class AddYesAccessibileApi {
  static final AddYesAccessibileApi _singleton =
      AddYesAccessibileApi._internal();
  AddYesAccessibileApi._internal();
  static AddYesAccessibileApi get instance => _singleton;

  Future<Map> addYesAccessibleApi({
    required String accessibilityStatus,
    required String restrictionReason,
    required String restrictionDescription,
    required int id,
  }) async {
    try {
      var data = ({
        "accessibility_status": accessibilityStatus,
        "restriction_reason": restrictionReason,
        "restriction_description": restrictionDescription,
        "id": id,
      });

      Response response = await postHttp(
        Endpoints.postYesAccessible(id: id),
        data,
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
