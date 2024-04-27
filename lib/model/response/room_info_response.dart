import 'package:json_annotation/json_annotation.dart';

part 'room_info_response.g.dart';

@JsonSerializable()
class ListRoomResponse {
  num? total_records;
  List<InfoRoom>? result;

  ListRoomResponse({
    this.total_records,
    this.result,
  });

  factory ListRoomResponse.fromJson(Map<String, dynamic> json) {
    return _$ListRoomResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListRoomResponseToJson(this);
}

@JsonSerializable()
class InfoRoom {
  num? id;
  String? name;
  bool? check_availability;
  List<dynamic>? company_id;
  String? display_name;

  InfoRoom({
    this.id,
    this.name,
    this.company_id,
    this.check_availability,
    this.display_name,
  });

  factory InfoRoom.fromJson(Map<String, dynamic> json) {
    return _$InfoRoomFromJson(json);
  }

  Map<String, dynamic> toJson() => _$InfoRoomToJson(this);
}
