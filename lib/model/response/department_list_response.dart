import 'package:json_annotation/json_annotation.dart';

part 'department_list_response.g.dart';

@JsonSerializable()
class DepartmentList {
  num? total_records;
  List<DepartmentInfo>? result;

  DepartmentList({
    this.total_records,
    this.result,
  });

  factory DepartmentList.fromJson(Map<String, dynamic> json) {
    return _$DepartmentListFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentListToJson(this);
}

@JsonSerializable()
class DepartmentInfo {
  num? id;
  String? name;

  DepartmentInfo({
    this.id,
    this.name,
  });

  factory DepartmentInfo.fromJson(Map<String, dynamic> json) {
    return _$DepartmentInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$DepartmentInfoToJson(this);
}

// @JsonSerializable()
// class EquipmentName {
//   num? id;

//   String? product_name;

//   EquipmentName({
//     this.id,
//     this.product_name,
//   });

//   factory EquipmentName.fromJson(Map<String, dynamic> json) {
//     return _$EquipmentNameFromJson(json);
//   }

//   Map<String, dynamic> toJson() => _$EquipmentNameToJson(this);
// }
