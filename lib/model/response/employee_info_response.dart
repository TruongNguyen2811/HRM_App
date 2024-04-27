import 'package:json_annotation/json_annotation.dart';

part 'employee_info_response.g.dart';

@JsonSerializable()
class ListEmployeeResponse {
  num? total_records;
  List<EmployeeInfo>? result;

  ListEmployeeResponse({
    this.total_records,
    this.result,
  });

  factory ListEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return _$ListEmployeeResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListEmployeeResponseToJson(this);
}

@JsonSerializable()
class EmployeeInfo {
  num? id;
  String? name;
  String? code;
  String? job_title;

  EmployeeInfo({
    this.id,
    this.name,
    this.code,
    this.job_title,
  });

  factory EmployeeInfo.fromJson(Map<String, dynamic> json) {
    return _$EmployeeInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EmployeeInfoToJson(this);
}
