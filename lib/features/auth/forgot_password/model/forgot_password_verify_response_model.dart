import 'dart:convert';

class ForgotPasswordVerifyResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ForgotPasswordVerifyResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ForgotPasswordVerifyResponseModel.fromRawJson(String str) =>
      ForgotPasswordVerifyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordVerifyResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ForgotPasswordVerifyResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class Data {
  String? resetToken;

  Data({this.resetToken});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) =>
      Data(resetToken: json["reset_token"]);

  Map<String, dynamic> toJson() => {"reset_token": resetToken};
}
