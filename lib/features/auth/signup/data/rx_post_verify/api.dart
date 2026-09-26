import 'package:connortaii_app/features/auth/signup/model/signup_verify_response_model.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/endpoints.dart';
import 'package:connortaii_app/networks/exception_handler/data_source.dart';
import 'package:dio/dio.dart';

final class SignupEmailVerifyOtpApi {
  static final SignupEmailVerifyOtpApi _singleton =
      SignupEmailVerifyOtpApi._internal();
  SignupEmailVerifyOtpApi._internal();
  static SignupEmailVerifyOtpApi get instance => _singleton;

  Future<SignupVerifyResponseModel> signupEmailVerifyOtpApi({
    required String email,
    required String otp,
  }) async {
    try {
      Map data = {"email": email, "otp": otp};

      Response response = await postHttp(Endpoints.registerEmailVerify(), data);

      if (response.statusCode == 200) {
        final data = SignupVerifyResponseModel.fromJson((response.data));

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
