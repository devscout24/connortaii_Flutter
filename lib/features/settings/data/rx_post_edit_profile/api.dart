import 'dart:io';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

final class EditProfileApi {
  static final EditProfileApi _singleton = EditProfileApi._internal();
  EditProfileApi._internal();
  static EditProfileApi get instance => _singleton;

  Future<Map> editProfileApi({
    XFile? avatar,
    required String? firstName,
    required String? lastName,
  }) async {
    try {
      FormData data = FormData.fromMap({
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
      });

      if (avatar != null && await File(avatar.path).exists()) {
        final fileType = avatar.path.split('.').last.toLowerCase();

        final contentType = fileType == 'png'
            ? MediaType('image', 'png')
            : (fileType == 'jpg' || fileType == 'jpeg')
            ? MediaType('image', 'jpeg')
            : null;

        if (contentType == null) {
          throw Exception("Invalid file type");
        }

        data.files.add(
          MapEntry(
            'avatar',
            await MultipartFile.fromFile(avatar.path, contentType: contentType),
          ),
        );
      }

      Response response = await postHttp(Endpoints.updateProfile(), data);

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
