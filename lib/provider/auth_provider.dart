import 'package:flutter/foundation.dart';

final class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _showPassword = true;
  bool _showConfirmPassword = true;
  bool _isSubscribed = false;
  String _forgotPasswordEmail = '';
  int _userId = -1;
  String _userName = "";
  String _userImage = "";
  String _otpCode = "";
  bool get isLoading => _isLoading;
  bool get isSubscribed => _isSubscribed;
  bool get showPassword => _showPassword;
  bool get showConfirmPassword => _showConfirmPassword;
  String get forgotPasswordEmail => _forgotPasswordEmail;
  int get userId => _userId;
  String get otp => _otpCode;
  String get userName => _userName;
  String get userImage => _userImage;

  void toogleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void toogleShowConfirmPassword() {
    _showConfirmPassword = !_showConfirmPassword;
    notifyListeners();
  }

  void toggleLoading({required bool isLoading}) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setEmail({required String email}) {
    _forgotPasswordEmail = email;
    notifyListeners();
  }

  void setOtp({required String otp}) {
    _otpCode = otp;
    notifyListeners();
  }
  void setUserId({required int id}) {
    _userId = id;
    notifyListeners();
  }
  void setUserName({required String name}) {
    _userName = name;
    notifyListeners();
  }
  void setUserImage({required String image}) {
    _userImage = image;
    notifyListeners();
  }


  void setSubscriptionStatus({required String? status}) {
    if(status != null && status == "active"){
      _isSubscribed = true;
    }else{
      _isSubscribed = false;
    }
    notifyListeners();
  }
}
