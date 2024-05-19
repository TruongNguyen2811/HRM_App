// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_booking_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListBookingRoomResponse _$ListBookingRoomResponseFromJson(
        Map<String, dynamic> json) =>
    ListBookingRoomResponse(
      total_records: json['total_records'] as num?,
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => BookingRoomInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListBookingRoomResponseToJson(
        ListBookingRoomResponse instance) =>
    <String, dynamic>{
      'total_records': instance.total_records,
      'result': instance.result,
    };

BookingRoomInfo _$BookingRoomInfoFromJson(Map<String, dynamic> json) =>
    BookingRoomInfo(
      id: json['id'] as num?,
      employee: json['employee'] as List<dynamic>?,
      room: json['room'] as List<dynamic>?,
      date_from: json['date_from'] as String?,
      date_to: json['date_to'] as String?,
      purpose: json['purpose'] as String?,
      req_date: json['req_date'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$BookingRoomInfoToJson(BookingRoomInfo instance) =>
    <String, dynamic>{
      'employee': instance.employee,
      'id': instance.id,
      'room': instance.room,
      'date_from': instance.date_from,
      'date_to': instance.date_to,
      'req_date': instance.req_date,
      'purpose': instance.purpose,
      'state': instance.state,
    };
