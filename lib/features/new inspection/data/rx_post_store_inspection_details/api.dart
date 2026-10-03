// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class StoreInspectionDetailsApi {
  static final StoreInspectionDetailsApi _singleton =
      StoreInspectionDetailsApi._internal();
  StoreInspectionDetailsApi._internal();
  static StoreInspectionDetailsApi get instance => _singleton;

  Future<Map> storeInspectionDetailsApi({
    required String email,
    required String resetToken,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      var data = ({
        "email": email,
        "reset_token": resetToken,
        "password": newPassword,
        "password_confirmation": confirmPassword,
      });

      Response response = await postHttp(
        Endpoints.storeInspectionDetails(),
        data,
      );

      if (response.statusCode == 200) {
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
