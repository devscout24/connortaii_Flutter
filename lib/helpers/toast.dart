import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

final class ToastUtil {
  ToastUtil._();
  static void showLongToast(String message) {
    try {
      String trn = message.tr;
      Fluttertoast.showToast(
        msg: trn,
        toastLength: Toast.LENGTH_LONG,
      ).catchError((_) => null);
    } catch (_) {}
  }

  static void showShortToast(String message) {
    try {
      Fluttertoast.showToast(
        msg: message.tr,
        toastLength: Toast.LENGTH_SHORT,
      ).catchError((_) => null);
    } catch (_) {}
  }

  static void showNoInternetToast() {
    try {
      Fluttertoast.showToast(
        msg: "Please check your internet connection".tr,
        toastLength: Toast.LENGTH_SHORT,
      ).catchError((_) => null);
    } catch (_) {}
  }

  static void showNotLoggedInToast() {
    try {
      Fluttertoast.showToast(
        msg: "Please login to perform this operation".tr,
        toastLength: Toast.LENGTH_SHORT,
      ).catchError((_) => null);
    } catch (_) {}
  }
}
