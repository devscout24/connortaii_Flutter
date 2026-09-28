import 'dart:convert';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgotPasswordResendOtpApi {
  static final ForgotPasswordResendOtpApi _singleton =
      ForgotPasswordResendOtpApi._internal();
  ForgotPasswordResendOtpApi._internal();
  static ForgotPasswordResendOtpApi get instance => _singleton;

  Future<Map> forgotPasswordResendOtpApi({required String email}) async {
    try {
      Map data = {"email": email};
      Response response = await postHttp(Endpoints.resendEmailVerify(), data);

      if (response.statusCode == 200) {
        final data = json.decode(json.encode(response.data));

        return data;
      } else {
        throw DataSource.DEFAULT.getFailure();
      }
    } catch (error) {
      // Handle generic errors
      // throw ErrorHandler.handle(error).failure.responseMessage;
      rethrow;
    }
  }
}
