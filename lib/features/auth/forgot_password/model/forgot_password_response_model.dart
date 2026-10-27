import 'dart:convert';

class ForgotPasswordResponseModel {
  bool? success;
  bool? status;
  String? message;
  ForgotPasswordData? data;
  int? code;

  ForgotPasswordResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
    this.code,
  });

  factory ForgotPasswordResponseModel.fromRawJson(String str) =>
      ForgotPasswordResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
        success: json["success"] ?? json["status"],
        status: json["status"] ?? json["success"],
        message: json["message"],
        data: json["data"] != null && json["data"] is Map<String, dynamic>
            ? ForgotPasswordData.fromJson(json["data"])
            : null,
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status": status,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class ForgotPasswordData {
  dynamic otp;

  ForgotPasswordData({this.otp});

  factory ForgotPasswordData.fromRawJson(String str) =>
      ForgotPasswordData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordData.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordData(otp: json["otp"]);

  Map<String, dynamic> toJson() => {"otp": otp};
}
