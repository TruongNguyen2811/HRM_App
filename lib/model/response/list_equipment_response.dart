import 'package:json_annotation/json_annotation.dart';

part 'list_equipment_response.g.dart';

@JsonSerializable()
class ListEquipmentResponse {
  num? total_records;
  List<Equipment>? result;

  ListEquipmentResponse({
    this.total_records,
    this.result,
  });

  factory ListEquipmentResponse.fromJson(Map<String, dynamic> json) {
    return _$ListEquipmentResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListEquipmentResponseToJson(this);
}

@JsonSerializable()
class Equipment {
  List<dynamic>? employee_name_id;
  num? id;
  List<dynamic>? department_name_id;
  String? name;
  String? create_date;
  String? status;
  List<EquipmentName>? equipment_request_ids;

  Equipment({
    this.id,
    this.employee_name_id,
    this.department_name_id,
    this.name,
    this.create_date,
    this.status,
    this.equipment_request_ids,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return _$EquipmentFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EquipmentToJson(this);
}

@JsonSerializable()
class EquipmentName {
  num? id;

  String? product_name;

  EquipmentName({
    this.id,
    this.product_name,
  });

  factory EquipmentName.fromJson(Map<String, dynamic> json) {
    return _$EquipmentNameFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EquipmentNameToJson(this);
}
