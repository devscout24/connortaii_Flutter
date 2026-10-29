import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class AddRestrictedAccessibilityApi {
  static final AddRestrictedAccessibilityApi _singleton =
      AddRestrictedAccessibilityApi._internal();
  AddRestrictedAccessibilityApi._internal();
  static AddRestrictedAccessibilityApi get instance => _singleton;

  Future<Map> addRestrictedAccessibilityApi({
    required String accessibilityStatus,
    required String restrictionReason,
    required String restrictionDescription,
    required int id,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "accessibility_status": accessibilityStatus,
        "id": id,
      };

      if (accessibilityStatus == 'restricted') {
        data["restriction_reason"] = restrictionReason;
        data["restriction_description"] = restrictionDescription;
      }

      Response response = await putHttp(
        Endpoints.putRestrictedAccessibility(id: id),
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
