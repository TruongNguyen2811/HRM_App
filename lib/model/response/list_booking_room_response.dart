import 'package:json_annotation/json_annotation.dart';

part 'list_booking_room_response.g.dart';

@JsonSerializable()
class ListBookingRoomResponse {
  num? total_records;
  List<BookingRoomInfo>? result;

  ListBookingRoomResponse({
    this.total_records,
    this.result,
  });

  factory ListBookingRoomResponse.fromJson(Map<String, dynamic> json) {
    return _$ListBookingRoomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListBookingRoomResponseToJson(this);
}

@JsonSerializable()
class BookingRoomInfo {
  List<dynamic>? employee;
  num? id;
  List<dynamic>? room;
  String? date_from;
  String? date_to;
  String? req_date;
  String? purpose;
  String? state;

  BookingRoomInfo({
    this.id,
    this.employee,
    this.room,
    this.date_from,
    this.date_to,
    this.purpose,
    this.req_date,
    this.state,
  });

  factory BookingRoomInfo.fromJson(Map<String, dynamic> json) {
    return _$BookingRoomInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BookingRoomInfoToJson(this);
}
