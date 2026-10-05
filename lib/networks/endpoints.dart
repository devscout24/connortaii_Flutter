// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");

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
  static String userChangePassword() => "/api/user/update-password";

  static String getPrivacyPolicy() => "/api/pages/privacy-policy";
  static String getTermsAndConditions() => "/api/pages/terms-conditions";

  //steps
  static String storeInspectionDetails() => "/api/inspections";
  static String addHealthSafetyResponse() => "/api/health-safety-responses/2";

  /////////============> Push Notification FCM Token <============////////////
  // static String sentFcmToken() => "/firebase-token/add";

  //---------------------------Get All Product Details------------------------
  // static String getProductDetails({required int productId}) {
  //   return appData.read(kKeyIsLoggedIn) == true
  //       ? "/api/product/auth/details/$productId"
  //       : "/api/product/details/$productId";
  // }
}
