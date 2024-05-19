import 'package:json_annotation/json_annotation.dart';

part 'attendance_request.g.dart';

@JsonSerializable()
class AttendanceRequest {
  final AttendanceModel? params;
  AttendanceRequest({
    this.params,
  });

  factory AttendanceRequest.fromJson(Map<String, dynamic> json) {
    return _$AttendanceRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttendanceRequestToJson(this);
}

@JsonSerializable()
class AttendanceModel {
  final List<dynamic>? args;

  AttendanceModel({
    this.args,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return _$AttendanceModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttendanceModelToJson(this);
}
