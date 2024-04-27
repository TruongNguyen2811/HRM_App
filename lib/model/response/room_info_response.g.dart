// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListRoomResponse _$ListRoomResponseFromJson(Map<String, dynamic> json) =>
    ListRoomResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => InfoRoom.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListRoomResponseToJson(ListRoomResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

InfoRoom _$InfoRoomFromJson(Map<String, dynamic> json) => InfoRoom(
      id: json['id'] as num?,
      name: json['name'] as String?,
      company_id: json['company_id'] as List<dynamic>?,
      check_availability: json['check_availability'] as bool?,
      display_name: json['display_name'] as String?,
    );

Map<String, dynamic> _$InfoRoomToJson(InfoRoom instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'check_availability': instance.check_availability,
      'company_id': instance.company_id,
      'display_name': instance.display_name,
    };
