import 'dart:developer';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';

final class SignupRx extends RxResponseInt<Map> {
  final api = SignupApi.instance;

  SignupRx({required super.empty, required super.dataFetcher});

  Future<bool> signupRx({
    XFile? avatar,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required bool agreeToTerms,
  }) async {
    try {
      Map data = await api.signupApi(
        avatar: avatar,
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        agreeToTerms: agreeToTerms,
      );

      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;

      if (statusCode == 422 && data != null) {
        final validationErrors = data["data"] is Map
            ? Map<String, dynamic>.from(data["data"])
            : <String, dynamic>{};

        final messages = <String>[];
        const fields = [
          "first_name",
          "last_name",
          "email",
          "password",
          "password_confirmation",
          "confirm_password",
          "agree_to_terms",
        ];

        for (final field in fields) {
          final value = validationErrors[field];
          if (value is List && value.isNotEmpty) {
            messages.add(value.first.toString());
          }
        }

        if (messages.isEmpty) {
          validationErrors.forEach((key, value) {
            if (value is List && value.isNotEmpty) {
              messages.add(value.first.toString());
            } else if (value is String && value.isNotEmpty) {
              messages.add(value);
            }
          });
        }

        if (messages.isNotEmpty) {
          ToastUtil.showLongToast(messages.first);
        } else {
          ToastUtil.showLongToast(data["message"] ?? "Validation Error");
        }
      } else {
        final errorMessage = data is Map
            ? data["message"] ?? data["error"]
            : null;
        ToastUtil.showLongToast(errorMessage ?? "Something went wrong");
      }
    }

    log(error.toString());
    dataFetcher.sink.addError(error);
    return false;
  }
}
