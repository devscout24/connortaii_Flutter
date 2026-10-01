// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class PasswordChangeApi {
  static final PasswordChangeApi _singleton = PasswordChangeApi._internal();
  PasswordChangeApi._internal();
  static PasswordChangeApi get instance => _singleton;

  Future<Map> passwordChangeApi({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    try {
      var data = {
        "old_password": currentPassword,
        "new_password": newPassword,
        "new_password_confirmation": confirmNewPassword,
      };

      Response response = await postHttp(Endpoints.userChangePassword(), data);

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
