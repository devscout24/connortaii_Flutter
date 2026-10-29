import 'dart:convert';

class HomeInspectionsResponseModel {
  bool? success;
  String? message;
  HomeData? data;
  int? code;

  HomeInspectionsResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory HomeInspectionsResponseModel.fromRawJson(String str) =>
      HomeInspectionsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeInspectionsResponseModel.fromJson(Map<String, dynamic> json) =>
      HomeInspectionsResponseModel(
        success: json["success"] ?? json["status"],
        message: json["message"],
        data: json["data"] != null && json["data"] is Map<String, dynamic>
            ? HomeData.fromJson(json["data"])
            : null,
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "code": code,
  };
}

class HomeData {
  HomeUser? user;
  List<RecentInspectionItem>? recentInspections;

  HomeData({this.user, this.recentInspections});

  factory HomeData.fromRawJson(String str) =>
      HomeData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    user: json["user"] != null && json["user"] is Map<String, dynamic>
        ? HomeUser.fromJson(json["user"])
        : null,
    recentInspections: json["recent_inspections"] == null
        ? []
        : List<RecentInspectionItem>.from(
            json["recent_inspections"]!.map(
              (x) => RecentInspectionItem.fromJson(x),
            ),
          ),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "recent_inspections": recentInspections == null
        ? []
        : List<dynamic>.from(recentInspections!.map((x) => x.toJson())),
  };
}

class HomeUser {
  int? id;
  String? name;
  String? avatar;

  HomeUser({this.id, this.name, this.avatar});

  factory HomeUser.fromRawJson(String str) =>
      HomeUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeUser.fromJson(Map<String, dynamic> json) => HomeUser(
    id: json["id"],
    name: json["name"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "avatar": avatar,
  };
}

class RecentInspectionItem {
  int? id;
  String? propertyName;
  String? propertyAddress;
  String? inspectionDate;
  String? status;
  dynamic healthSafetyCompleted;
  int? totalSections;
  int? completedSections;

  RecentInspectionItem({
    this.id,
    this.propertyName,
    this.propertyAddress,
    this.inspectionDate,
    this.status,
    this.healthSafetyCompleted,
    this.totalSections,
    this.completedSections,
  });

  factory RecentInspectionItem.fromRawJson(String str) =>
      RecentInspectionItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RecentInspectionItem.fromJson(Map<String, dynamic> json) =>
      RecentInspectionItem(
        id: json["id"],
        propertyName: json["property_name"],
        propertyAddress: json["property_address"],
        inspectionDate: json["inspection_date"],
        status: json["status"],
        healthSafetyCompleted: json["health_safety_completed"],
        totalSections: json["total_sections"] != null
            ? int.tryParse(json["total_sections"].toString())
            : 10,
        completedSections: json["completed_sections"] != null
            ? int.tryParse(json["completed_sections"].toString())
            : 0,
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "property_name": propertyName,
    "property_address": propertyAddress,
    "inspection_date": inspectionDate,
    "status": status,
    "health_safety_completed": healthSafetyCompleted,
    "total_sections": totalSections,
    "completed_sections": completedSections,
  };
}
