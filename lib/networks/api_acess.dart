import 'package:connortaii_app/features/auth/forgot_password/data/rx_post_forgot_create_new_password/rx.dart';
import 'package:connortaii_app/features/auth/forgot_password/data/rx_post_forgot_password/rx.dart';
import 'package:connortaii_app/features/auth/forgot_password/data/rx_post_forgot_password_verify/rx.dart';
import 'package:connortaii_app/features/auth/forgot_password/data/rx_post_forgot_resend_otp_verify/rx.dart';
import 'package:connortaii_app/features/auth/forgot_password/model/forgot_password_verify_response_model.dart';
import 'package:connortaii_app/features/auth/login/data/rx_post_sign_in/rx.dart';
import 'package:connortaii_app/features/auth/login/model/login_response_model.dart';
import 'package:connortaii_app/features/auth/signup/data/rx_post_resend_otp_verify/rx.dart';
import 'package:connortaii_app/features/auth/signup/data/rx_post_verify/rx.dart';
import 'package:connortaii_app/features/auth/signup/model/signup_verify_response_model.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_get_health_safety_item_by_inspection/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_get_inspection_overview/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_get_inspection_section_accessible/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_post_add_health_safety_check/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_post_store_inspection_details/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_post_yes_accessible/rx.dart';
import 'package:connortaii_app/features/new%20inspection/data/rx_put_restricted_accessibility/rx.dart';
import 'package:connortaii_app/features/new%20inspection/model/get_health_safety_items_by_inspection_response_model.dart';
import 'package:connortaii_app/features/new%20inspection/model/get_inspection_overview_response_model.dart';
import 'package:connortaii_app/features/new%20inspection/model/get_section_accessible_response_model.dart';
import 'package:connortaii_app/features/settings/data/rx_delete_account/rx.dart';
import 'package:connortaii_app/features/settings/data/rx_get_privacy_policy/rx.dart';
import 'package:connortaii_app/features/settings/data/rx_get_profile/rx.dart';
import 'package:connortaii_app/features/settings/data/rx_get_terms_condition/rx.dart';

import 'package:connortaii_app/features/settings/data/rx_post_change_password/rx.dart';
import 'package:connortaii_app/features/settings/data/rx_post_edit_profile/rx.dart';
import 'package:connortaii_app/features/settings/data/rx_post_log_out/rx.dart';
import 'package:connortaii_app/features/settings/model/get_privacy_policy_response_model.dart';
import 'package:connortaii_app/features/settings/model/get_terms_condition_response_model.dart';
import 'package:connortaii_app/features/settings/model/profile_details_response_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:connortaii_app/features/auth/signup/data/rx_post_create_profile/rx.dart';

SignupRx signupRxOBJ = SignupRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

SignupEmailVerifyOtpRx signupEmailVerifyOtpRxObj = SignupEmailVerifyOtpRx(
  empty: SignupVerifyResponseModel(),
  dataFetcher: BehaviorSubject<SignupVerifyResponseModel>(),
);

SignupResendOtpRx signupResendOtpRxOBJ = SignupResendOtpRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

LoginRX loginRXObj = LoginRX(
  empty: LoginResponseModel(),
  dataFetcher: BehaviorSubject<LoginResponseModel>(),
);

ForgotPasswordRx forgotPasswordRxOBJ = ForgotPasswordRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

ForgotPasswordOtpVerifyRx forgotPasswordOtpVerifyRxObj =
    ForgotPasswordOtpVerifyRx(
      empty: ForgotPasswordVerifyResponseModel(),
      dataFetcher: BehaviorSubject<ForgotPasswordVerifyResponseModel>(),
    );

ForgotPasswordChangeRx forgotPasswordChangeRxOBJ = ForgotPasswordChangeRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

ForgotPasswordResendOtpRx forgotPasswordResendOtpRxOBJ =
    ForgotPasswordResendOtpRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

LogOutRx logOutRXOBJ = LogOutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

GetProfileRX getProfileRXObj = GetProfileRX(
  empty: ProfileDetailsResponseModel(),
  dataFetcher: BehaviorSubject<ProfileDetailsResponseModel>(),
);

EditProfileRx editProfileRxOBJ = EditProfileRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

DeleteAccountRx deleteAccountRxObj = DeleteAccountRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PasswordChangeRx passwordChangeRxOBJ = PasswordChangeRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

PrivacyPolicyRX privacyPolicyRXObj = PrivacyPolicyRX(
  empty: GetPrivacyPolicyResponseModel(),
  dataFetcher: BehaviorSubject<GetPrivacyPolicyResponseModel>(),
);

TermsAndConditionsRX termsAndConditionsRXObj = TermsAndConditionsRX(
  empty: GetTermsConditionResponseModel(),
  dataFetcher: BehaviorSubject<GetTermsConditionResponseModel>(),
);

StoreInspectionDetailsRx storeInspectionDetailsRxOBJ = StoreInspectionDetailsRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

AddHealthSafetyCheckRx addHealthSafetyCheckRxOBJ = AddHealthSafetyCheckRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);

GetHealthSafetyItemsByInspectionRX getHealthSafetyItemsByInspectionRXObj =
    GetHealthSafetyItemsByInspectionRX(
      empty: GetHealthSafetyItemsByInspectionResponseModel(),
      dataFetcher:
          BehaviorSubject<GetHealthSafetyItemsByInspectionResponseModel>(),
    );

GetInspectionOverViewRX getInspectionOverViewRXObj = GetInspectionOverViewRX(
  empty: GetInspectionOverViewResponseModel(),
  dataFetcher: BehaviorSubject<GetInspectionOverViewResponseModel>(),
);

GetSectionAccessibleRX getSectionAccessibleRXObj = GetSectionAccessibleRX(
  empty: GetSectionAccessibleResponseModel(),
  dataFetcher: BehaviorSubject<GetSectionAccessibleResponseModel>(),
);

AddRestrictedAccessibilityRx addRestrictedAccessibilityRxOBJ =
    AddRestrictedAccessibilityRx(
      empty: {},
      dataFetcher: BehaviorSubject<Map>(),
    );

AddYesAccessibleRx addYesAccessibleRxOBJ = AddYesAccessibleRx(
  empty: {},
  dataFetcher: BehaviorSubject<Map>(),
);
