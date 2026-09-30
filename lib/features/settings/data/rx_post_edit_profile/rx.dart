// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages
import 'dart:developer';
import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/helpers/di.dart';
import 'package:connortaii_app/helpers/toast.dart';
import 'package:connortaii_app/networks/dio/dio.dart';
import 'package:connortaii_app/networks/rx_base.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'api.dart';

final class EditProfileRx extends RxResponseInt<Map> {
  final api = EditProfileApi.instance;

  EditProfileRx({required super.empty, required super.dataFetcher});

  Future<bool> editProfileRx({
    XFile? avatar,
    required String? firstName,
    required String? lastName,
  }) async {
    try {
      Map data = await api.editProfileApi(
        avatar: avatar,
        firstName: firstName,
        lastName: lastName,
      );
      handleSuccessWithReturn(data);
      return true;
    } catch (error) {
      handleErrorWithReturn(error);
      return false;
    }
  }

  @override
  handleSuccessWithReturn(data) {
    appData.write(kKeyUserImage, data);
    appData.write(kKeyIsLoggedIn, true);
    DioSingleton.instance.update(appData.read(kKeyAccessToken));

    dataFetcher.sink.add(data);
    return data;
  }

  @override
  handleErrorWithReturn(dynamic error) {
    if (error is DioException) {
      final response = error.response?.data;

      ToastUtil.showShortToast(
        response["message"] ?? response["error"] ?? "Something went wrong",
      );
    }
    dataFetcher.sink.addError(error);
    log(error.toString());
    return false;
  }
}
