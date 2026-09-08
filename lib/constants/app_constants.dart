import 'dart:ui';

final class AppRegExpText {
  AppRegExpText._();
  // Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
      "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}

class OrderStatusNo {
  static const String kPENDING = '0'; //order just placed
  static const String kACCEPTED = '10'; //after accepted by shop owner
  static const String kFOODPROCESSING = '20';
  static const String kFOODREADY = '21';
  static const String kFOODPICKED = '30';
  static const String kFOODDELIVERED = '40';
  static const String kCANCELLED = '80';
  static const String kREJECTEDBYSHOP = '90';
  static const String kFAILED = '100';
  static const String kALL = 'all';
}

class DeliveryStatusNo {
  static const String kPENDIG = '0';
  static const String kDELIVERYMANCONFIRMED = '10';
  static const String kDELIVERYSTARTED = '11';
  static const String kARRIVEDATSHOP = '20';
  static const String kONTRANSIT = '30';
  static const String kDELIVERED = '40';
}

class OrderStatusColor {
  //Order Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kACCEPTED = Color(0xFF0b79fa);
  static const Color kFOODPROCESSING = Color(0xFF31a2b8);
  static const Color kFOODREADY = Color(0xFFffc234);
  static const Color kFOODPICKED = Color(0xFF6658dd);
  static const Color kFOODDELIVERED = Color(0xFF4fa744);
  static const Color kCANCELLED = Color(0xFFdd4246);
  static const Color kREJECTEDBYSHOP = Color(0xFFdd4246);
  static const Color kFAILED = Color(0xFFdd4246);
}

class DeliveryStatusColor {
  //Delivery Status Color Code
  static const Color kPENDING = Color(0xFF6c757d);
  static const Color kDELIVERYMANCONFIRMED = Color(0xFF0b79fa);
  static const Color kDELIVERYSTARTED = Color(0xFF6658dd);
  static const Color kARRIVEDATSHOP = Color(0xFFffc234);
  static const Color kONTRANSIT = Color(0xFFa5d23c);
  static const Color kDELIVERED = Color(0xFF4fa744);
}

const String kImageUrl = 'imageUrl';
// Keys
const String kKeyQuranArabic = 'quran_arabic';
const String kKeyQuranTranslation = 'quran_Translation';
const String kKeyQuranAudio = 'quran_audio';
const String kKeyStatus = 'status';
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyIsFirstTime = 'is_first_time';
const String kKeyAccessToken = 'access_token';
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeySelectedLat = 'selected_lot';
const String kKeySelectedLng = 'selected_lng';
const String kKeyAddress = 'address';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'language_code';
const String kKeyName = 'name';
const String kKeyToken = 'token';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';
const String kKeyFaqText = 'faq_text';
const String kKeyTermsAndConditionsText = 'toc_text';
const String kKeyAverageRating = 'average_rating';
const String kKeyViews = 'views';
const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyEnglish = 'en';
const String kKeyArabic = 'ar';
const String kKeyPortuguese = 'pt';
const String kKeyFrench = 'fr';
const String kKeyGerman = 'de';
const String kKeySpanish = 'es';
const String kKeyRussian = 'ru';
const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'lst_name';
const String kKeyDeviceID = 'device_id';
const String kKeyUserID = 'user_id';
const String kKeyShopID = 'shop_id';
const String kKeycategoriesID = 'categoriesId';
const String kKeyproductID = 'productId';
const String kKeyShopSlug = 'shop_slug';
const String kKeyRestaurantID = 'productId';
const String kKeyIsExploring = 'exploring';
const String kKeyScheduledPrayers = 'scheduled_prayers';
const String kKeyUserImage = 'user_image';
const String kKeyUserEmail = 'user_email';
const String kKeyotpVerifyToken = 'otp_verify_token';
const String kKeystripeAccountId = 'stripe_account_id';
const String kKeyFCMToken = 'fcm_token';

//order statuses

const List<String> kLanguagesKey = [kKeyEnglish, kKeyArabic];
const Map languages = <String, String>{
  kKeyEnglish: "English",
  kKeyArabic: "Arabic",
};
const Map countriesCode = <String, String>{kKeyEnglish: "US", kKeyArabic: "SA"};

class DefaultValue {
  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
}

String description =
    'Lorem ipsum dolor sit amet consectetur. Blandit tellus sed porttitor blandit. Adipiscing ut elementum tempus quis lacus velit pulvinar volutpat penatibus. Blandit arcu adipiscing fermentum dui donec leo.';

String termsAndConditionsScreenDescription =
    'Lorem ipsum dolor sit amet consectetur. Eu porta risus facilisis porttitor netus id. Nascetur elementum in eget nisi massa libero consequat. Consectetur egestas tellus tristique neque volutpat vestibulum diam congue. Sit lectus suspendisse nulla lectus faucibus ultricies egestas eget viverra. Pretium cursus tortor ut mi massa ac ultrices. Iaculis eget sit imperdiet aliquet faucibus mauris id. Donec pretium phasellus enim tellus urna. Sollicitudin non ac odio senectus. Mattis eget fringilla cras ut. Sem sit habitant vestibulum et eu tellus vitae viverra. Purus lectus lectus non faucibus leo cum. Risus nunc in nisl amet at elementum. Justo nibh iaculis enim vulputate odio leo. Sed ac pretium at nulla libero mattis imperdiet est vitae. Elementum fames gravida ultrices quam vel tincidunt a. Habitant eget nulla nibh odio accumsan in. Amet cras bibendum sollicitudin in non. Purus nec sed maecenas in lorem. Gravida morbi sapien nulla pellentesque commodo placerat purus sagittis consequat. \n\n Justo nibh iaculis enim vulputate odio leo. Sed ac pretium at nulla libero mattis imperdiet est vitae. Elementum fames gravida ultrices quam vel tincidunt a. Habitant eget nulla nibh odio accumsan in. Amet cras bibendum sollicitudin in non. Purus nec sed maecenas in lorem. Gravida morbi sapien nulla pellentesque commodo .';

String privacyDescription =
    'Thank you for trusting NutriAI. Your privacy is important to us. This Privacy Policy explains how us. collects, uses, and protects your personal information when you use the NutriAI mobile application.\n\nBy using NutriAI, you agree to be bound by these Terms. If you do not agree with any part of the Terms, please do not access or use the App.';
