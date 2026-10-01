import 'dart:convert';

class GetPrivacyPolicyResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GetPrivacyPolicyResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory GetPrivacyPolicyResponseModel.fromRawJson(String str) =>
      GetPrivacyPolicyResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPrivacyPolicyResponseModel.fromJson(Map<String, dynamic> json) =>
      GetPrivacyPolicyResponseModel(
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
  String? pageTitle;
  String? pageSlug;
  String? pageContent;

  Data({this.id, this.pageTitle, this.pageSlug, this.pageContent});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    pageTitle: json["page_title"],
    pageSlug: json["page_slug"],
    pageContent: json["page_content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "page_title": pageTitle,
    "page_slug": pageSlug,
    "page_content": pageContent,
  };
}
