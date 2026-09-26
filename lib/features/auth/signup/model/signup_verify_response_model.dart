import 'dart:convert';

class SignupVerifyResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  SignupVerifyResponseModel({this.success, this.message, this.data, this.code});

  factory SignupVerifyResponseModel.fromRawJson(String str) =>
      SignupVerifyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      SignupVerifyResponseModel(
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
  String? firstName;
  String? lastName;
  String? email;
  int? agreeToTerms;
  dynamic avatar;
  int? id;
  String? token;

  Data({
    this.firstName,
    this.lastName,
    this.email,
    this.agreeToTerms,
    this.avatar,
    this.id,
    this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    agreeToTerms: json["agree_to_terms"],
    avatar: json["avatar"],
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "agree_to_terms": agreeToTerms,
    "avatar": avatar,
    "id": id,
    "token": token,
  };
}
