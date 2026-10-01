import 'dart:convert';

class GetPrivacyPolicyResponseModel {
  bool? status;
  int? code;
  String? message;
  Data? data;

  GetPrivacyPolicyResponseModel({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetPrivacyPolicyResponseModel.fromRawJson(String str) =>
      GetPrivacyPolicyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPrivacyPolicyResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPrivacyPolicyResponseModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? content;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Data({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    content: json["content"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "content": content,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
