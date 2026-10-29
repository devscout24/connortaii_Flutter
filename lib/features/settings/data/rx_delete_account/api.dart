import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../../../../networks/dio/dio.dart';
import '../../../../../../../networks/endpoints.dart';
import '../../../../../../../networks/exception_handler/data_source.dart';

final class DeleteAccountApi {
  static final DeleteAccountApi _singleton = DeleteAccountApi._internal();
  DeleteAccountApi._internal();
  static DeleteAccountApi get instance => _singleton;

  Future<Map> deleteAccountApi() async {
    try {
      Response response = await deleteHttp(Endpoints.deleteAccount());

      if (response.statusCode == 200 || response.statusCode == 204) {
        final data = response.data != null
            ? json.decode(json.encode(response.data))
            : {'success': true};
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      rethrow;
    }
  }
}
