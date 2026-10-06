// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class AddHealthSafetyCheckApi {
  static final AddHealthSafetyCheckApi _singleton =
      AddHealthSafetyCheckApi._internal();

  AddHealthSafetyCheckApi._internal();

  static AddHealthSafetyCheckApi get instance => _singleton;

  Future<Map> addHealthSafetyCheckApi({
    required int inspectionId,
    required int healthSafetyItemId,
    required bool isChecked,
    required bool hasConcern,
    required String concernDetails,
    int? responseId,
  }) async {
    try {
      final data = {
        "inspection_id": inspectionId,
        "health_safety_item_id": healthSafetyItemId,
        "is_checked": isChecked,
        "has_concern": hasConcern,
        "concern_details": concernDetails,
      };

      Response response;

      if (responseId != null) {
        // update existing response using its id in the URL
        response = await putHttp(
          Endpoints.updateHealthSafetyResponse(responseId: responseId),
          data,
        );
      } else {
        // create new response
        response = await postHttp(Endpoints.createHealthSafetyResponse(), data);
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(json.encode(response.data));
        return responseBody;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
