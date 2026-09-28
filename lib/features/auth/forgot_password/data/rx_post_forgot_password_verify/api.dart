import 'package:connortaii_app/features/auth/forgot_password/model/forgot_password_verify_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class ForgotPasswordVerifyOtpApi {
  static final ForgotPasswordVerifyOtpApi _singleton =
      ForgotPasswordVerifyOtpApi._internal();
  ForgotPasswordVerifyOtpApi._internal();
  static ForgotPasswordVerifyOtpApi get instance => _singleton;

  Future<ForgotPasswordVerifyResponseModel> forgotPasswordVerifyOtpApi({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = {"email": email, "otp": otp};

      Response response = await postHttp(
        Endpoints.forgotPasswordVerifyOtp(),
        data,
      );

      if (response.statusCode == 200) {
        final data = ForgotPasswordVerifyResponseModel.fromJson(
          (response.data),
        );

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
