import 'dart:convert';

class InspectionsResponseModel {
  bool? success;
  String? message;
  List<InspectionItemModel>? data;
  int? code;

  InspectionsResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory InspectionsResponseModel.fromRawJson(String str) =>
      InspectionsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InspectionsResponseModel.fromJson(Map<String, dynamic> json) {
    List<InspectionItemModel> items = [];
    final rawData = json["data"];

    if (rawData is List) {
      items = rawData
          .whereType<Map>()
          .map((x) => InspectionItemModel.fromJson(Map<String, dynamic>.from(x)))
          .toList();
    } else if (rawData is Map) {
      if (rawData["data"] is List) {
        items = (rawData["data"] as List)
            .whereType<Map>()
            .map((x) => InspectionItemModel.fromJson(Map<String, dynamic>.from(x)))
            .toList();
      } else if (rawData["inspections"] is List) {
        items = (rawData["inspections"] as List)
            .whereType<Map>()
            .map((x) => InspectionItemModel.fromJson(Map<String, dynamic>.from(x)))
            .toList();
      }
    }

    return InspectionsResponseModel(
      success: json["success"] ?? json["status"] ?? true,
      message: json["message"],
      data: items,
      code: json["code"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "code": code,
      };
}

class InspectionItemModel {
  int? id;
  String? propertyName;
  String? propertyAddress;
  String? inspectionDate;
  String? status;
  dynamic healthSafetyCompleted;
  int? totalSections;
  int? completedSections;
  String? reportUrl;
  String? pdfUrl;

  InspectionItemModel({
    this.id,
    this.propertyName,
    this.propertyAddress,
    this.inspectionDate,
    this.status,
    this.healthSafetyCompleted,
    this.totalSections,
    this.completedSections,
    this.reportUrl,
    this.pdfUrl,
  });

  factory InspectionItemModel.fromRawJson(String str) =>
      InspectionItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory InspectionItemModel.fromJson(Map<String, dynamic> json) {
    final reportMap = json["report"] is Map
        ? Map<String, dynamic>.from(json["report"])
        : null;

    final parsedReportUrl = json["report_url"] ??
        json["download_url"] ??
        reportMap?["url"] ??
        reportMap?["download_url"] ??
        '';

    final parsedPdfUrl = json["pdf_url"] ??
        json["file_path"] ??
        json["file"] ??
        reportMap?["pdf_url"] ??
        reportMap?["file_path"] ??
        parsedReportUrl;

    return InspectionItemModel(
      id: json["id"] is int ? json["id"] : int.tryParse(json["id"]?.toString() ?? ''),
      propertyName: (json["property_name"] ?? json["title"] ?? json["name"] ?? '').toString(),
      propertyAddress: (json["property_address"] ?? json["address"] ?? '').toString(),
      inspectionDate: (json["inspection_date"] ?? json["date"] ?? json["created_at"] ?? '').toString(),
      status: (json["status"] ?? 'in_progress').toString(),
      healthSafetyCompleted: json["health_safety_completed"],
      totalSections: json["total_sections"] != null
          ? int.tryParse(json["total_sections"].toString()) ?? 10
          : 10,
      completedSections: json["completed_sections"] != null
          ? int.tryParse(json["completed_sections"].toString()) ?? 0
          : 0,
      reportUrl: parsedReportUrl.toString(),
      pdfUrl: parsedPdfUrl.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "property_name": propertyName,
        "property_address": propertyAddress,
        "inspection_date": inspectionDate,
        "status": status,
        "health_safety_completed": healthSafetyCompleted,
        "total_sections": totalSections,
        "completed_sections": completedSections,
        "report_url": reportUrl,
        "pdf_url": pdfUrl,
      };
}

