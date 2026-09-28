import 'dart:convert';

class ForgotPasswordVerifyResponseModel {
  int? code;
  String? success;
  String? token;
  User? user;

  ForgotPasswordVerifyResponseModel({
    this.code,
    this.success,
    this.token,
    this.user,
  });

  factory ForgotPasswordVerifyResponseModel.fromRawJson(String str) =>
      ForgotPasswordVerifyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ForgotPasswordVerifyResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => ForgotPasswordVerifyResponseModel(
    code: json["code"],
    success: json["success"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "success": success,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? role;
  String? status;
  dynamic lastLoginAt;
  dynamic lastLoginIp;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  dynamic avatar;
  DateTime? dateOfBirth;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? resetPasswordToken;
  DateTime? resetPasswordTokenExp;

  User({
    this.id,
    this.role,
    this.status,
    this.lastLoginAt,
    this.lastLoginIp,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.avatar,
    this.dateOfBirth,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.resetPasswordToken,
    this.resetPasswordTokenExp,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    role: json["role"],
    status: json["status"],
    lastLoginAt: json["last_login_at"],
    lastLoginIp: json["last_login_ip"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    phone: json["phone"],
    avatar: json["avatar"],
    dateOfBirth: json["date_of_birth"] == null
        ? null
        : DateTime.parse(json["date_of_birth"]),
    emailVerifiedAt: json["email_verified_at"] == null
        ? null
        : DateTime.parse(json["email_verified_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    resetPasswordToken: json["reset_password_token"],
    resetPasswordTokenExp: json["reset_password_token_exp"] == null
        ? null
        : DateTime.parse(json["reset_password_token_exp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "role": role,
    "status": status,
    "last_login_at": lastLoginAt,
    "last_login_ip": lastLoginIp,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "phone": phone,
    "avatar": avatar,
    "date_of_birth":
        "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "email_verified_at": emailVerifiedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "reset_password_token": resetPasswordToken,
    "reset_password_token_exp": resetPasswordTokenExp?.toIso8601String(),
  };
}
