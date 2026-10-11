import 'dart:convert';

class GetInspectionOverViewResponseModel {
  bool? success;
  String? message;
  List<Datum>? data;
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
    data: json["data"] == null
        ? []
        : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
    "code": code,
  };
}

class Datum {
  int? id;
  int? inspectionId;
  String? sectionType;
  Status? accessibilityStatus;
  dynamic restrictionReason;
  dynamic restrictionDescription;
  int? isCompleted;
  Status? overallStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Checkpoint>? checkpoints;

  Datum({
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

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    inspectionId: json["inspection_id"],
    sectionType: json["section_type"],
    accessibilityStatus: statusValues.map[json["accessibility_status"]],
    restrictionReason: json["restriction_reason"],
    restrictionDescription: json["restriction_description"],
    isCompleted: json["is_completed"],
    overallStatus: statusValues.map[json["overall_status"]],
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
    "accessibility_status": statusValues.reverse[accessibilityStatus],
    "restriction_reason": restrictionReason,
    "restriction_description": restrictionDescription,
    "is_completed": isCompleted,
    "overall_status": statusValues.reverse[overallStatus],
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "checkpoints": checkpoints == null
        ? []
        : List<dynamic>.from(checkpoints!.map((x) => x.toJson())),
  };
}

enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

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
