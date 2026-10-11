import 'dart:convert';

class GetSectionAccessibleResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? code;

  GetSectionAccessibleResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory GetSectionAccessibleResponseModel.fromRawJson(String str) =>
      GetSectionAccessibleResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetSectionAccessibleResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => GetSectionAccessibleResponseModel(
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
  int? inspectionId;
  String? sectionType;
  String? accessibilityStatus;
  dynamic restrictionReason;
  dynamic restrictionDescription;
  int? isCompleted;
  String? overallStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Checkpoint>? checkpoints;

  Data({
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
    this.checkpoints,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
