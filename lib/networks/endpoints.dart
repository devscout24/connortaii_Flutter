// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
// const String url = "https://fabricr00tz.svaalpha.com";

const String url = "https://connortaii.thewarriors.team";

final class NetworkConstants {
  NetworkConstants._();
  static const ACCEPT = "Accept";
  static const APP_KEY = "App-Key";
  static const ACCEPT_LANGUAGE = "Accept-Language";
  static const ACCEPT_LANGUAGE_VALUE = "pt";
  static const APP_KEY_VALUE = String.fromEnvironment("APP_KEY_VALUE");
  static const ACCEPT_TYPE = "application/json";
  static const AUTHORIZATION = "Authorization";
  static const CONTENT_TYPE = "content-Type";
}

final class Endpoints {
  Endpoints._();
  //backend_url
  static String logIn() => "/api/users/login";
  static String logout() => "/api/user/logout";
  static String deleteAccount() => "/api/user/delete-account";
  static String getUserProfile() => "/api/user";
  static String updateProfile() => "/api/user/update";

  static String register() => "/api/users/register";
  static String registerEmailVerify() => "/api/users/register/otp-verify";
  static String resendEmailVerify() => "/api/users/register/otp-resend";

  static String forgotPassword() => "/api/users/login/email-verify";
  static String forgotPasswordVerifyOtp() => "/api/users/login/otp-verify";
  static String forgotPasswordResendOtp() => "/api/users/login/otp-resend";
  static String forgotChangePassword() => "/api/users/login/reset-password";
  static String userChangePassword() => "/api/user/update/password";

  /////////============> Push Notification FCM Token <============////////////
  // static String sentFcmToken() => "/firebase-token/add";

  //---------------------------Get All Product Details------------------------
  // static String getProductDetails({required int productId}) {
  //   return appData.read(kKeyIsLoggedIn) == true
  //       ? "/api/product/auth/details/$productId"
  //       : "/api/product/details/$productId";
  // }

  // static String getAllProduct({
  //   required String search,
  //   int? page,
  //   int? categoryId,
  //   String? priceRange,
  //   String? rating,
  //   int? size,
  //   String? color,
  //   int? brand,
  //   String? type,
  // }) {
  //   String url = appData.read(kKeyIsLoggedIn) == true
  //       ? "/api/product/auth?search=$search"
  //       : "/api/product?search=$search";

  //   if (page != null) {
  //     url += "&page=$page";
  //   }

  //   if (categoryId != null && categoryId != 0) {
  //     url += "&category_id=$categoryId";
  //   }
  //   if (priceRange != null && priceRange.isNotEmpty) {
  //     url += "&price_range=$priceRange";
  //   }
  //   if (rating != null && rating.isNotEmpty) url += "&rating=$rating";
  //   if (size != null && size != 0) url += "&size_id=$size";
  //   if (color != null && color.isNotEmpty) url += "&color_code=$color";
  //   if (brand != null && brand != 0) url += "&brand_id=$brand";
  //   if (type != null && type.isNotEmpty) url += "&type=$type";

  //   return url;
  // }
}


    //main
    // String url = "/api/product/auth?search=$search";

    // String baseUrl = appData.read(kKeyToken) != null
    //     ? "/api/product/auth"
    //     : "/api/product";

    // String url = "$baseUrl?search=$search";


  // static String getAllProduct({
  //   required String search,
  //   required int categoryId,
  // }) => categoryId == 0
  //     ? "/api/product/auth?search=$search"
  //     : "/api/product/auth?search=$search&category_id=$categoryId";