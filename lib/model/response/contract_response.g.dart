// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListContractResponse _$ListContractResponseFromJson(
        Map<String, dynamic> json) =>
    ListContractResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => ContractInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListContractResponseToJson(
        ListContractResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

ContractInfo _$ContractInfoFromJson(Map<String, dynamic> json) => ContractInfo(
      id: json['id'] as num?,
      employee_id: json['employee_id'] as List<dynamic>?,
      department_id: json['department_id'] as List<dynamic>?,
      name: json['name'] as String?,
      job_id: json['job_id'] as List<dynamic>?,
      company_id: json['company_id'] as List<dynamic>?,
      contract_type_id: json['contract_type_id'] as List<dynamic>?,
      date_end: json['date_end'] as String?,
      date_start: json['date_start'] as String?,
      employee_code: json['employee_code'] as String?,
      resource_calendar_id: json['resource_calendar_id'] as List<dynamic>?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$ContractInfoToJson(ContractInfo instance) =>
    <String, dynamic>{
      'employee_id': instance.employee_id,
      'id': instance.id,
      'name': instance.name,
      'department_id': instance.department_id,
      'job_id': instance.job_id,
      'resource_calendar_id': instance.resource_calendar_id,
      'company_id': instance.company_id,
      'contract_type_id': instance.contract_type_id,
      'employee_code': instance.employee_code,
      'date_start': instance.date_start,
      'date_end': instance.date_end,
      'state': instance.state,
    };
