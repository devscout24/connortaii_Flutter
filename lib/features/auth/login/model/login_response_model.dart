import 'dart:convert';

class LoginResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  LoginResponseModel({this.success, this.message, this.data, this.code});

  factory LoginResponseModel.fromRawJson(String str) =>
      LoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
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
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic avatar;
  int? agreeToTerms;
  String? token;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.agreeToTerms,
    this.token,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    avatar: json["avatar"],
    agreeToTerms: json["agree_to_terms"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "avatar": avatar,
    "agree_to_terms": agreeToTerms,
    "token": token,
  };
}
