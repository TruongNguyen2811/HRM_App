// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_leave_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListLeaveResponse _$ListLeaveResponseFromJson(Map<String, dynamic> json) =>
    ListLeaveResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => LeaveInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListLeaveResponseToJson(ListLeaveResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

LeaveInfo _$LeaveInfoFromJson(Map<String, dynamic> json) => LeaveInfo(
      id: json['id'] as num?,
      user_id: json['user_id'] as List<dynamic>?,
      holiday_status_id: json['holiday_status_id'] as List<dynamic>?,
      date_from: json['date_from'] as String?,
      date_to: json['date_to'] as String?,
      holiday_status_name: json['holiday_status_name'] as String?,
      display_name: json['display_name'] as String?,
      activity_state: json['activity_state'],
      for_reasons: json['for_reasons'],
      reasons: json['reasons'],
      state: json['state'] as String?,
    );

Map<String, dynamic> _$LeaveInfoToJson(LeaveInfo instance) => <String, dynamic>{
      'user_id': instance.user_id,
      'id': instance.id,
      'holiday_status_id': instance.holiday_status_id,
      'date_from': instance.date_from,
      'date_to': instance.date_to,
      'display_name': instance.display_name,
      'holiday_status_name': instance.holiday_status_name,
      'for_reasons': instance.for_reasons,
      'activity_state': instance.activity_state,
      'reasons': instance.reasons,
      'state': instance.state,
    };
