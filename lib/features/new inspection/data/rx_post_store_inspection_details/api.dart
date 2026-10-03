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
    required String inspectorName,
    required String email,
    required String mobileNumber,
    required String propertyAddress,
    required String propertyName,
    required String inspectionDate,
    required String propertyOwnerName,
    required String propertyOwnerPresence,
    required String otherPeoplePresence,
    required String houseOccupied,
    required String propertyFurnished,
    required String buildingType,
    required String statusOfUtilities,
    required String weatherDuringInspection,
  }) async {
    try {
      var data = ({
        "inspector_name": inspectorName,
        "email": email,
        "mobile_number": mobileNumber,
        "property_address": propertyAddress,
        "property_name": propertyName,
        "inspection_date": inspectionDate,
        "property_owner_name": propertyOwnerName,
        "property_owner_presence": propertyOwnerPresence,
        "other_people_presence": otherPeoplePresence,
        "house_occupied": houseOccupied,
        "property_furnished": propertyFurnished,
        "building_type": buildingType,
        "status_of_utilities": statusOfUtilities,
        "weather_during_inspection": weatherDuringInspection,
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
