// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KPIResponse _$KPIResponseFromJson(Map<String, dynamic> json) => KPIResponse(
      employee_code: json['employee_code'] as String?,
      date: json['date'] as String?,
      employee_name: json['employee_name'] as String?,
      company_name: json['company_name'] as String?,
      department_name: json['department_name'] as String?,
      employee_level: json['employee_level'] as int?,
      compensation_amount_week_1:
          (json['compensation_amount_week_1'] as num?)?.toDouble(),
      compensation_amount_week_2:
          (json['compensation_amount_week_2'] as num?)?.toDouble(),
      compensation_amount_week_3:
          (json['compensation_amount_week_3'] as num?)?.toDouble(),
      compensation_amount_week_4:
          (json['compensation_amount_week_4'] as num?)?.toDouble(),
      compensation_amount_week_5:
          (json['compensation_amount_week_5'] as num?)?.toDouble(),
      compensation_status_week_1: json['compensation_status_week_1'],
      compensation_status_week_2: json['compensation_status_week_2'],
      compensation_status_week_3: json['compensation_status_week_3'],
      compensation_status_week_4: json['compensation_status_week_4'],
      compensation_status_week_5: json['compensation_status_week_5'],
      book_review_compensation:
          (json['book_review_compensation'] as num?)?.toDouble(),
      book_review_compensation_status: json['book_review_compensation_status'],
      total_compensation: (json['total_compensation'] as num?)?.toDouble(),
      date_send_week_1: json['date_send_week_1'],
      date_send_week_2: json['date_send_week_2'],
      date_send_week_3: json['date_send_week_3'],
      date_send_week_4: json['date_send_week_4'],
      date_send_week_5: json['date_send_week_5'],
      use_percen_tage: json['use_percen_tage'],
      id: json['id'] as int?,
      lastUpdate: json['lastUpdate'] as String?,
      display_name: json['display_name'] as String?,
      createUid: json['createUid'] as int?,
      createDate: json['createDate'] as String?,
      writeUid: json['writeUid'] as int?,
      writeDate: json['writeDate'] as String?,
    );

Map<String, dynamic> _$KPIResponseToJson(KPIResponse instance) =>
    <String, dynamic>{
      'employee_code': instance.employee_code,
      'date': instance.date,
      'employee_name': instance.employee_name,
      'company_name': instance.company_name,
      'department_name': instance.department_name,
      'employee_level': instance.employee_level,
      'compensation_amount_week_1': instance.compensation_amount_week_1,
      'compensation_amount_week_2': instance.compensation_amount_week_2,
      'compensation_amount_week_3': instance.compensation_amount_week_3,
      'compensation_amount_week_4': instance.compensation_amount_week_4,
      'compensation_amount_week_5': instance.compensation_amount_week_5,
      'compensation_status_week_1': instance.compensation_status_week_1,
      'compensation_status_week_2': instance.compensation_status_week_2,
      'compensation_status_week_3': instance.compensation_status_week_3,
      'compensation_status_week_4': instance.compensation_status_week_4,
      'compensation_status_week_5': instance.compensation_status_week_5,
      'book_review_compensation': instance.book_review_compensation,
      'book_review_compensation_status':
          instance.book_review_compensation_status,
      'total_compensation': instance.total_compensation,
      'date_send_week_1': instance.date_send_week_1,
      'date_send_week_2': instance.date_send_week_2,
      'date_send_week_3': instance.date_send_week_3,
      'date_send_week_4': instance.date_send_week_4,
      'date_send_week_5': instance.date_send_week_5,
      'use_percen_tage': instance.use_percen_tage,
      'id': instance.id,
      'lastUpdate': instance.lastUpdate,
      'display_name': instance.display_name,
      'createUid': instance.createUid,
      'createDate': instance.createDate,
      'writeUid': instance.writeUid,
      'writeDate': instance.writeDate,
    };
