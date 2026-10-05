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
    required bool isChecked,
    required bool hasConcern,
    required String concernDetails,
  }) async {
    try {
      var data = ({
        "is_checked": isChecked,
        "has_concern": hasConcern,
        "concern_details": concernDetails,
      });

      Response response = await postHttp(
        Endpoints.addHealthSafetyCheck(),
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
