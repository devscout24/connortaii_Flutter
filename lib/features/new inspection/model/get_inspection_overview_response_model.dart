import 'dart:convert';

class GetInspectionOverViewResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GetInspectionOverViewResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory GetInspectionOverViewResponseModel.fromRawJson(String str) =>
      GetInspectionOverViewResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetInspectionOverViewResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => GetInspectionOverViewResponseModel(
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
  int? totalSections;
  int? completedSections;
  List<Section>? sections;

  Data({this.totalSections, this.completedSections, this.sections});

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalSections: json["total_sections"],
    completedSections: json["completed_sections"],
    sections: json["sections"] == null
        ? []
        : List<Section>.from(json["sections"]!.map((x) => Section.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_sections": totalSections,
    "completed_sections": completedSections,
    "sections": sections == null
        ? []
        : List<dynamic>.from(sections!.map((x) => x.toJson())),
  };
}

class Section {
  int? id;
  int? inspectionId;
  String? sectionType;
  String? accessibilityStatus;
  dynamic restrictionReason;
  dynamic restrictionDescription;
  int? isCompleted;
  String? overallStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? label;
  int? order;
  List<Checkpoint>? checkpoints;

  Section({
    this.id,
    this.inspectionId,
    this.sectionType,
    this.accessibilityStatus,
    this.restrictionReason,
    this.restrictionDescription,
    this.isCompleted,
    this.overallStatus,
    this.createdAt,
    this.updatedAt,
    this.label,
    this.order,
    this.checkpoints,
  });

  factory Section.fromRawJson(String str) => Section.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json["id"],
    inspectionId: json["inspection_id"],
    sectionType: json["section_type"],
    accessibilityStatus: json["accessibility_status"],
    restrictionReason: json["restriction_reason"],
    restrictionDescription: json["restriction_description"],
    isCompleted: json["is_completed"],
    overallStatus: json["overall_status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    label: json["label"],
    order: json["order"],
    checkpoints: json["checkpoints"] == null
        ? []
        : List<Checkpoint>.from(
            json["checkpoints"]!.map((x) => Checkpoint.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inspection_id": inspectionId,
    "section_type": sectionType,
    "accessibility_status": accessibilityStatus,
    "restriction_reason": restrictionReason,
    "restriction_description": restrictionDescription,
    "is_completed": isCompleted,
    "overall_status": overallStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "label": label,
    "order": order,
    "checkpoints": checkpoints == null
        ? []
        : List<dynamic>.from(checkpoints!.map((x) => x.toJson())),
  };
}

class Checkpoint {
  int? id;
  int? inspectionSectionId;
  String? checkpointKey;
  String? label;
  dynamic type;
  dynamic levelOfConcern;
  dynamic observations;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic>? photos;

  Checkpoint({
    this.id,
    this.inspectionSectionId,
    this.checkpointKey,
    this.label,
    this.type,
    this.levelOfConcern,
    this.observations,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.photos,
  });

  factory Checkpoint.fromRawJson(String str) =>
      Checkpoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Checkpoint.fromJson(Map<String, dynamic> json) => Checkpoint(
    id: json["id"],
    inspectionSectionId: json["inspection_section_id"],
    checkpointKey: json["checkpoint_key"],
    label: json["label"],
    type: json["type"],
    levelOfConcern: json["level_of_concern"],
    observations: json["observations"],
    order: json["order"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    photos: json["photos"] == null
        ? []
        : List<dynamic>.from(json["photos"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inspection_section_id": inspectionSectionId,
    "checkpoint_key": checkpointKey,
    "label": label,
    "type": type,
    "level_of_concern": levelOfConcern,
    "observations": observations,
    "order": order,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "photos": photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
