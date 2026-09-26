// ignore_for_file: constant_identifier_names

// const String url = String.fromEnvironment("BASE_URL");
// const String url = "https://fabricr00tz.svaalpha.com";

import 'package:connortaii_app/constants/app_constants.dart';
import 'package:connortaii_app/helpers/di.dart';

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
  static String logIn() => "/api/auth/login";
  static String logout() => "/api/auth/logout";
  static String deleteAccount() => "/api/auth/delete";
  static String getUserProfile() => "/api/user/profile";
  static String updateProfile() => "/api/user/update";

  static String register() => "/api/users/register";
  static String registerEmailVerify() => "/api/users/register/otp-verify";
  static String resendEmailVerify() => "/api/auth/resend-otp";
  static String forgotPassword() => "/api/password/forget";
  static String forgotPasswordVerifyOtp() => "/api/password/verify-email";
  static String forgotChangePassword() => "/api/password/new";
  static String userChangePassword() => "/api/user/update/password";
  static String getSlider() => "/api/slider";
  static String getCategory() => "/api/category";
  static String trendingAuthProduct() {
    return appData.read(kKeyIsLoggedIn) == true
        ? "/api/product/auth/trending?items=10"
        : "/api/product/trending?items=10";
  }

  // static String latestAuthProduct() => "/api/product/latest";
  static String latestAuthProduct() {
    return appData.read(kKeyIsLoggedIn) == true
        ? "/api/product/auth/latest"
        : "/api/product/latest";
  }

  static String getWishlistProduct({required String search, int? categoryId}) =>
      "/api/wishlist?search=$search&category_id=$categoryId";

  static String addRemoveWishlist() => "/api/wishlist/toggle";

  static String addToCart() => "/api/cart/add-to-cart";
  // static String getCartItems(String? couponCode) {
  //   if (couponCode != null && couponCode.isNotEmpty) {
  //     return "/api/cart/cart-list?coupon_code=$couponCode";
  //   } else {
  //     return "/api/cart/cart-list";
  //   }
  // }
  static String getCartItems(String? couponCode) =>
      couponCode != null && couponCode.isNotEmpty
      ? "/api/cart/cart-list?coupon=$couponCode"
      : "/api/cart/cart-list";

  static String removeCartItems({required int productId}) =>
      "/api/cart/cart-remove/$productId";
  static String incrementDecrementCartItem() => "/api/cart/quantity";

  static String getPrivacyPolicy() => "/api/dynamic/privacy-policy";
  static String getHelpCenter() => "/api/dynamic/support";
  static String getNotification() => "/api/notifications";

  static String getMyOrder() => "/api/order/my-orders";
  static String getMyOrderDetails({
    required String orderId,
    required int itemId,
  }) => "/api/order/product/details?order_id=$orderId&item_id=$itemId";

  static String sendFeedBack() => "/api/ratings";
  static String checkoutProductOrder() => "/api/order/place-order";
  static String paymentProductOrder() => "/api/order/paid";
  static String getStripePulishableKey() => "/api/settings/stripe";

  /////////============> Push Notification FCM Token <============////////////
  static String sentFcmToken() => "/firebase-token/add";

  //---------------------------Get All Product Details------------------------
  static String getProductDetails({required int productId}) {
    return appData.read(kKeyIsLoggedIn) == true
        ? "/api/product/auth/details/$productId"
        : "/api/product/details/$productId";
  }

  static String getAllProduct({
    required String search,
    int? page,
    int? categoryId,
    String? priceRange,
    String? rating,
    int? size,
    String? color,
    int? brand,
    String? type,
  }) {
    String url = appData.read(kKeyIsLoggedIn) == true
        ? "/api/product/auth?search=$search"
        : "/api/product?search=$search";

    if (page != null) {
      url += "&page=$page";
    }

    if (categoryId != null && categoryId != 0) {
      url += "&category_id=$categoryId";
    }
    if (priceRange != null && priceRange.isNotEmpty) {
      url += "&price_range=$priceRange";
    }
    if (rating != null && rating.isNotEmpty) url += "&rating=$rating";
    if (size != null && size != 0) url += "&size_id=$size";
    if (color != null && color.isNotEmpty) url += "&color_code=$color";
    if (brand != null && brand != 0) url += "&brand_id=$brand";
    if (type != null && type.isNotEmpty) url += "&type=$type";

    return url;
  }
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