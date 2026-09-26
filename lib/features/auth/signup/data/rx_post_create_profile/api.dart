import 'dart:io';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

final class SignupApi {
  static final SignupApi _singleton = SignupApi._internal();
  SignupApi._internal();
  static SignupApi get instance => _singleton;

  Future<Map> signupApi({
    XFile? avatar,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required bool agreeToTerms,
  }) async {
    try {
      final formData = FormData.fromMap({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "agree_to_terms": agreeToTerms ? 1 : 0,
      });

      if (avatar != null && await File(avatar.path).exists()) {
        formData.files.add(
          MapEntry(
            'avatar',
            await MultipartFile.fromFile(
              avatar.path,
              filename: avatar.name,
              contentType: MediaType('image', 'jpeg'),
            ),
          ),
        );
      }

      final response = await postHttp(Endpoints.register(), formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception("Failed to create profile");
      }
    } catch (error) {
      rethrow;
    }
  }
}
