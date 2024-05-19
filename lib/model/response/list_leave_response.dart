import 'package:json_annotation/json_annotation.dart';

part 'list_leave_response.g.dart';

@JsonSerializable()
class ListLeaveResponse {
  num? total_records;
  List<LeaveInfo>? result;

  ListLeaveResponse({
    this.total_records,
    this.result,
  });

  factory ListLeaveResponse.fromJson(Map<String, dynamic> json) {
    return _$ListLeaveResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListLeaveResponseToJson(this);
}

@JsonSerializable()
class LeaveInfo {
  List<dynamic>? user_id;
  num? id;
  List<dynamic>? holiday_status_id;
  String? date_from;
  String? date_to;
  String? display_name;
  String? holiday_status_name;
  dynamic for_reasons;
  dynamic activity_state;
  dynamic reasons;

  LeaveInfo({
    this.id,
    this.user_id,
    this.holiday_status_id,
    this.date_from,
    this.date_to,
    this.holiday_status_name,
    this.display_name,
    this.activity_state,
    this.for_reasons,
    this.reasons,
  });

  factory LeaveInfo.fromJson(Map<String, dynamic> json) {
    return _$LeaveInfoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LeaveInfoToJson(this);
}
