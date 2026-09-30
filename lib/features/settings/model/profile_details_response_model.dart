import 'dart:convert';

class ProfileDetailsResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  ProfileDetailsResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory ProfileDetailsResponseModel.fromRawJson(String str) =>
      ProfileDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileDetailsResponseModel(
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

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.avatar,
    this.agreeToTerms,
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "avatar": avatar,
    "agree_to_terms": agreeToTerms,
  };
}
