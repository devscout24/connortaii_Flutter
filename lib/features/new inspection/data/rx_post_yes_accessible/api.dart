import 'dart:convert';
import 'dart:io';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

final class AddYesAccessibileApi {
  static final AddYesAccessibileApi _singleton =
      AddYesAccessibileApi._internal();
  AddYesAccessibileApi._internal();
  static AddYesAccessibileApi get instance => _singleton;

  Future<Map> addYesAccessibleApi({
    required String type,
    required String levelOfConcern,
    required String observations,
    required int id,
    XFile? photo,
  }) async {
    try {
      final formData = FormData.fromMap({
        "type": type,
        "level_of_concern": levelOfConcern,
        "observations": observations,
        "id": id,
      });
      if (photo != null && await File(photo.path).exists()) {
        final ext = photo.path.split('.').last.toLowerCase();
        final mediaType = ext == 'png'
            ? MediaType('image', 'png')
            : (ext == 'webp'
                ? MediaType('image', 'webp')
                : MediaType('image', 'jpeg'));
        formData.files.add(
          MapEntry(
            'photo',
            await MultipartFile.fromFile(
              photo.path,
              filename: photo.name.isNotEmpty
                  ? photo.name
                  : photo.path.split('/').last,
              contentType: mediaType,
            ),
          ),
        );
      }

      Response response = await postHttp(
        Endpoints.postYesAccessible(id: id),
        formData,
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
