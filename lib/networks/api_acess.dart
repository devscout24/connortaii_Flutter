import 'package:connortaii_app/features/auth/signup/data/rx_post_verify/rx.dart';
import 'package:connortaii_app/features/auth/signup/model/signup_verify_response_model.dart';
import 'package:rxdart/rxdart.dart';

// LoginRX loginRXObj = LoginRX(
//   empty: LoginResponseModel(),
//   dataFetcher: BehaviorSubject<LoginResponseModel>(),
// );

// LogOutRx logOutRXOBJ = LogOutRx(empty: {}, dataFetcher: BehaviorSubject<Map>());
import 'package:connortaii_app/features/auth/signup/data/rx_post_create_profile/rx.dart';

SignupRx signupRxOBJ = SignupRx(empty: {}, dataFetcher: BehaviorSubject<Map>());

SignupEmailVerifyOtpRx signupEmailVerifyOtpRxObj = SignupEmailVerifyOtpRx(
  empty: SignupVerifyResponseModel(),
  dataFetcher: BehaviorSubject<SignupVerifyResponseModel>(),
);
