import 'dart:convert';

class GetHealthSafetyItemsByInspectionResponseModel {
  bool? success;
  String? message;
  List<Datum>? data;
  int? code;

  GetHealthSafetyItemsByInspectionResponseModel({
    this.success,
    this.message,
    this.data,
    this.code,
  });

  factory GetHealthSafetyItemsByInspectionResponseModel.fromRawJson(
    String str,
  ) => GetHealthSafetyItemsByInspectionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetHealthSafetyItemsByInspectionResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => GetHealthSafetyItemsByInspectionResponseModel(
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
  int? healthSafetyItemId;
  bool? isChecked;
  bool? hasConcern;
  String? concernDetails;
  DateTime? createdAt;
  DateTime? updatedAt;
  Item? item;

  Datum({
    this.id,
    this.inspectionId,
    this.healthSafetyItemId,
    this.isChecked,
    this.hasConcern,
    this.concernDetails,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    inspectionId: json["inspection_id"],
    healthSafetyItemId: json["health_safety_item_id"],
    isChecked: json["is_checked"],
    hasConcern: json["has_concern"],
    concernDetails: json["concern_details"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    item: json["item"] == null ? null : Item.fromJson(json["item"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "inspection_id": inspectionId,
    "health_safety_item_id": healthSafetyItemId,
    "is_checked": isChecked,
    "has_concern": hasConcern,
    "concern_details": concernDetails,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "item": item?.toJson(),
  };
}

class Item {
  int? id;
  String? key;
  String? label;
  int? isHazard;
  String? description;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
    this.id,
    this.key,
    this.label,
    this.isHazard,
    this.description,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    key: json["key"],
    label: json["label"],
    isHazard: json["is_hazard"],
    description: json["description"],
    order: json["order"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "label": label,
    "is_hazard": isHazard,
    "description": description,
    "order": order,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
