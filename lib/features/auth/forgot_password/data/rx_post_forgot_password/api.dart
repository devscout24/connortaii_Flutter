import 'package:connortaii_app/features/auth/forgot_password/model/forgot_password_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgotPasswordApi {
  static final ForgotPasswordApi _singleton = ForgotPasswordApi._internal();
  ForgotPasswordApi._internal();
  static ForgotPasswordApi get instance => _singleton;

  Future<ForgotPasswordResponseModel> forgotPasswordApi({
    required String email,
  }) async {
    try {
      FormData data = FormData.fromMap({"email": email.trim()});

      Response response = await postHttp(Endpoints.forgotPassword(), data);

      if (response.statusCode == 200) {
        final data = ForgotPasswordResponseModel.fromJson(
          Map<String, dynamic>.from(response.data),
        );
        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      rethrow;
    }
  }
}
