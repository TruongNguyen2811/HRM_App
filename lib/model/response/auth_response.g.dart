// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
      data: json['data'] == null
          ? null
          : ProfileAuthResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

ProfileAuthResponse _$ProfileAuthResponseFromJson(Map<String, dynamic> json) =>
    ProfileAuthResponse(
      user_id: json['user_id'] as num?,
      department_id: json['department_id'] as num?,
      display_name: json['display_name'] as String?,
      company_id: json['company_id'] as num?,
      access_token: json['access_token'] as String?,
      company_name: json['company_name'] as String?,
      employee_ho: json['employee_ho'] as bool?,
      employee_id: json['employee_id'] as num?,
      expires_in: json['expires_in'],
      is_administrative: json['is_administrative'] as bool?,
      is_department_secretary: json['is_department_secretary'] as bool?,
      is_general_manager: json['is_general_manager'] as bool?,
      is_head_of_department: json['is_head_of_department'] as bool?,
      refresh_expires_in: json['refresh_expires_in'],
      refresh_token: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$ProfileAuthResponseToJson(
        ProfileAuthResponse instance) =>
    <String, dynamic>{
      'user_id': instance.user_id,
      'department_id': instance.department_id,
      'display_name': instance.display_name,
      'company_id': instance.company_id,
      'company_name': instance.company_name,
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
      'refresh_token': instance.refresh_token,
      'refresh_expires_in': instance.refresh_expires_in,
      'is_general_manager': instance.is_general_manager,
      'is_head_of_department': instance.is_head_of_department,
      'is_department_secretary': instance.is_department_secretary,
      'employee_ho': instance.employee_ho,
      'is_administrative': instance.is_administrative,
      'employee_id': instance.employee_id,
    };
