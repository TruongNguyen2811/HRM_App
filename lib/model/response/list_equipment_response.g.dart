// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_equipment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEquipmentResponse _$ListEquipmentResponseFromJson(
        Map<String, dynamic> json) =>
    ListEquipmentResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListEquipmentResponseToJson(
        ListEquipmentResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

Equipment _$EquipmentFromJson(Map<String, dynamic> json) => Equipment(
      id: json['id'] as num?,
      employee_name_id: json['employee_name_id'] as List<dynamic>?,
      department_name_id: json['department_name_id'] as List<dynamic>?,
      name: json['name'] as String?,
      create_date: json['create_date'] as String?,
      status: json['status'] as String?,
      equipment_request_ids: (json['equipment_request_ids'] as List<dynamic>?)
          ?.map((e) => EquipmentName.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquipmentToJson(Equipment instance) => <String, dynamic>{
      'employee_name_id': instance.employee_name_id,
      'id': instance.id,
      'department_name_id': instance.department_name_id,
      'name': instance.name,
      'create_date': instance.create_date,
      'status': instance.status,
      'equipment_request_ids': instance.equipment_request_ids,
    };

EquipmentName _$EquipmentNameFromJson(Map<String, dynamic> json) =>
    EquipmentName(
      id: json['id'] as num?,
      product_name: json['product_name'] as String?,
    );

Map<String, dynamic> _$EquipmentNameToJson(EquipmentName instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.product_name,
    };
