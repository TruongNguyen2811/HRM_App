import 'package:json_annotation/json_annotation.dart';

part 'contract_response.g.dart';

@JsonSerializable()
class ListContractResponse {
  num? total_records;
  List<ContractInfo>? result;

  ListContractResponse({
    this.total_records,
    this.result,
  });

  factory ListContractResponse.fromJson(Map<String, dynamic> json) {
    return _$ListContractResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListContractResponseToJson(this);
}

@JsonSerializable()
class ContractInfo {
  List<dynamic>? employee_id;
  num? id;
  String? name;
  List<dynamic>? department_id;
  List<dynamic>? job_id;
  List<dynamic>? resource_calendar_id;
  List<dynamic>? company_id;
  List<dynamic>? contract_type_id;
  String? employee_code;
  String? date_start;
  String? date_end;
  String? state;

  ContractInfo({
    this.id,
    this.employee_id,
    this.department_id,
    this.name,
    this.job_id,
    this.company_id,
    this.contract_type_id,
    this.date_end,
    this.date_start,
    this.employee_code,
    this.resource_calendar_id,
    this.state,
  });

  factory ContractInfo.fromJson(Map<String, dynamic> json) {
    return _$ContractInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ContractInfoToJson(this);
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
