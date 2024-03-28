// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceResponse _$AttendanceResponseFromJson(Map<String, dynamic> json) =>
    AttendanceResponse(
      id: json['id'] as num?,
      attendance_attempt_1: json['attendance_attempt_1'] as String?,
      attendance_attempt_2: json['attendance_attempt_2'] as String?,
      attendance_attempt_3: json['attendance_attempt_3'] as String?,
      attendance_attempt_4: json['attendance_attempt_4'] as String?,
      attendance_attempt_5: json['attendance_attempt_5'] as String?,
      attendance_attempt_6: json['attendance_attempt_6'] as String?,
      check_is_enough_time: json['check_is_enough_time'] as bool?,
      company: json['company'] as String?,
      date: json['date'] as String?,
      day_of_week: json['day_of_week'] as num?,
      department: json['department'] as String?,
      employee_code: json['employee_code'] as String?,
      employee_name: json['employee_name'] as String?,
      holiday_name: json['holiday_name'] as String?,
      is_holiday: json['is_holiday'] as bool?,
      is_worked: json['is_worked'] as bool?,
      job_title: json['job_title'] as String?,
      last_attendance_attempt: json['last_attendance_attempt'] as String?,
      leave_early: json['leave_early'] as num?,
      surplus_minute_work: json['surplus_minute_work'] as num?,
      time_keeping_code: json['time_keeping_code'] as String?,
      total_attendance: json['total_attendance'] as num?,
      total_work_time: json['total_work_time'] as num?,
    );

Map<String, dynamic> _$AttendanceResponseToJson(AttendanceResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day_of_week': instance.day_of_week,
      'total_attendance': instance.total_attendance,
      'employee_name': instance.employee_name,
      'employee_code': instance.employee_code,
      'time_keeping_code': instance.time_keeping_code,
      'department': instance.department,
      'company': instance.company,
      'job_title': instance.job_title,
      'holiday_name': instance.holiday_name,
      'date': instance.date,
      'is_worked': instance.is_worked,
      'check_is_enough_time': instance.check_is_enough_time,
      'is_holiday': instance.is_holiday,
      'attendance_attempt_1': instance.attendance_attempt_1,
      'attendance_attempt_2': instance.attendance_attempt_2,
      'attendance_attempt_3': instance.attendance_attempt_3,
      'attendance_attempt_4': instance.attendance_attempt_4,
      'attendance_attempt_5': instance.attendance_attempt_5,
      'attendance_attempt_6': instance.attendance_attempt_6,
      'last_attendance_attempt': instance.last_attendance_attempt,
      'surplus_minute_work': instance.surplus_minute_work,
      'leave_early': instance.leave_early,
      'total_work_time': instance.total_work_time,
    };
