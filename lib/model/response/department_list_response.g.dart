// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DepartmentList _$DepartmentListFromJson(Map<String, dynamic> json) =>
    DepartmentList(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => DepartmentInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DepartmentListToJson(DepartmentList instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

DepartmentInfo _$DepartmentInfoFromJson(Map<String, dynamic> json) =>
    DepartmentInfo(
      id: json['id'] as num?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$DepartmentInfoToJson(DepartmentInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
