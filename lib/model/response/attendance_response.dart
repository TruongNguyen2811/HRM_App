import 'package:json_annotation/json_annotation.dart';

part 'attendance_response.g.dart';

@JsonSerializable()
class AttendanceResponse {
  num? id;
  num? day_of_week;
  num? total_attendance;
  String? employee_name;
  String? employee_code;
  String? time_keeping_code;
  String? department;
  String? company;
  String? job_title;
  String? holiday_name;
  String? date;
  bool? is_worked;
  bool? check_is_enough_time;
  bool? is_holiday;
  String? attendance_attempt_1;
  String? attendance_attempt_2;
  String? attendance_attempt_3;
  String? attendance_attempt_4;
  String? attendance_attempt_5;
  String? attendance_attempt_6;
  String? last_attendance_attempt;
  num? surplus_minute_work;
  num? leave_early;
  num? total_work_time;

  AttendanceResponse({
    this.id,
    this.attendance_attempt_1,
    this.attendance_attempt_2,
    this.attendance_attempt_3,
    this.attendance_attempt_4,
    this.attendance_attempt_5,
    this.attendance_attempt_6,
    this.check_is_enough_time,
    this.company,
    this.date,
    this.day_of_week,
    this.department,
    this.employee_code,
    this.employee_name,
    this.holiday_name,
    this.is_holiday,
    this.is_worked,
    this.job_title,
    this.last_attendance_attempt,
    this.leave_early,
    this.surplus_minute_work,
    this.time_keeping_code,
    this.total_attendance,
    this.total_work_time,
  });

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) {
    return _$AttendanceResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);
}
