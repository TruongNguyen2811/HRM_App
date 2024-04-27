// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEmployeeResponse _$ListEmployeeResponseFromJson(
        Map<String, dynamic> json) =>
    ListEmployeeResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => EmployeeInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListEmployeeResponseToJson(
        ListEmployeeResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

EmployeeInfo _$EmployeeInfoFromJson(Map<String, dynamic> json) => EmployeeInfo(
      id: json['id'] as num?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      job_title: json['job_title'] as String?,
    );

Map<String, dynamic> _$EmployeeInfoToJson(EmployeeInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'job_title': instance.job_title,
    };
