import 'dart:convert';

class UserReportsResponseModel {
  bool? success;
  String? message;
  List<UserReportItemModel>? data;
  int? code;

  UserReportsResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory UserReportsResponseModel.fromRawJson(String str) =>
      UserReportsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReportsResponseModel.fromJson(Map<String, dynamic> json) {
    List<UserReportItemModel> items = [];
    final rawData = json["data"];

    if (rawData is List) {
      items = rawData
          .whereType<Map>()
          .map((x) => UserReportItemModel.fromJson(Map<String, dynamic>.from(x)))
          .toList();
    } else if (rawData is Map) {
      if (rawData["data"] is List) {
        items = (rawData["data"] as List)
            .whereType<Map>()
            .map((x) => UserReportItemModel.fromJson(Map<String, dynamic>.from(x)))
            .toList();
      } else if (rawData["reports"] is List) {
        items = (rawData["reports"] as List)
            .whereType<Map>()
            .map((x) => UserReportItemModel.fromJson(Map<String, dynamic>.from(x)))
            .toList();
      }
    }

    return UserReportsResponseModel(
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

class UserReportItemModel {
  int? id;
  int? inspectionId;
  String? title;
  String? address;
  String? date;
  String? pdfUrl;
  String? downloadUrl;
  String? status;

  UserReportItemModel({
    this.id,
    this.inspectionId,
    this.title,
    this.address,
    this.date,
    this.pdfUrl,
    this.downloadUrl,
    this.status,
  });

  factory UserReportItemModel.fromRawJson(String str) =>
      UserReportItemModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserReportItemModel.fromJson(Map<String, dynamic> json) {
    final inspection = json["inspection"] is Map
        ? Map<String, dynamic>.from(json["inspection"])
        : null;

    final parsedTitle = json["property_name"] ??
        inspection?["property_name"] ??
        json["title"] ??
        json["report_name"] ??
        json["name"] ??
        (json["id"] != null ? "Inspection #${json["id"]}" : "Inspection Report");

    final parsedAddress = json["property_address"] ??
        inspection?["property_address"] ??
        json["address"] ??
        '';

    final parsedDate = json["inspection_date"] ??
        inspection?["inspection_date"] ??
        json["date"] ??
        json["created_at"] ??
        '';

    final parsedPdf = json["pdf_url"] ??
        json["file_path"] ??
        json["report_file"] ??
        json["file"] ??
        json["url"] ??
        '';

    final parsedDownload = json["download_url"] ?? parsedPdf;

    return UserReportItemModel(
      id: json["id"] is int ? json["id"] : int.tryParse(json["id"]?.toString() ?? ''),
      inspectionId: json["inspection_id"] is int
          ? json["inspection_id"]
          : int.tryParse(
              json["inspection_id"]?.toString() ?? inspection?["id"]?.toString() ?? '',
            ),
      title: parsedTitle.toString(),
      address: parsedAddress.toString(),
      date: parsedDate.toString(),
      pdfUrl: parsedPdf.toString(),
      downloadUrl: parsedDownload.toString(),
      status: (json["status"] ?? inspection?["status"] ?? "completed").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "inspection_id": inspectionId,
        "title": title,
        "address": address,
        "date": date,
        "pdf_url": pdfUrl,
        "download_url": downloadUrl,
        "status": status,
      };
}

