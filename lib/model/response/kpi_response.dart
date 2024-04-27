import 'package:json_annotation/json_annotation.dart';

part 'kpi_response.g.dart';

@JsonSerializable()
class KPIResponse {
  String? employee_code;
  String? date;
  String? employee_name;
  String? company_name;
  String? department_name;
  int? employee_level;
  double? compensation_amount_week_1;
  double? compensation_amount_week_2;
  double? compensation_amount_week_3;
  double? compensation_amount_week_4;
  double? compensation_amount_week_5;
  dynamic compensation_status_week_1;
  dynamic compensation_status_week_2;
  dynamic compensation_status_week_3;
  dynamic compensation_status_week_4;
  dynamic compensation_status_week_5;
  double? book_review_compensation;
  dynamic book_review_compensation_status;
  double? total_compensation;
  dynamic date_send_week_1;
  dynamic date_send_week_2;
  dynamic date_send_week_3;
  dynamic date_send_week_4;
  dynamic date_send_week_5;
  dynamic use_percen_tage;
  int? id;
  String? lastUpdate;
  String? display_name;
  int? createUid;
  String? createDate;
  int? writeUid;
  String? writeDate;

  KPIResponse(
      {this.employee_code,
      this.date,
      this.employee_name,
      this.company_name,
      this.department_name,
      this.employee_level,
      this.compensation_amount_week_1,
      this.compensation_amount_week_2,
      this.compensation_amount_week_3,
      this.compensation_amount_week_4,
      this.compensation_amount_week_5,
      this.compensation_status_week_1,
      this.compensation_status_week_2,
      this.compensation_status_week_3,
      this.compensation_status_week_4,
      this.compensation_status_week_5,
      this.book_review_compensation,
      this.book_review_compensation_status,
      this.total_compensation,
      this.date_send_week_1,
      this.date_send_week_2,
      this.date_send_week_3,
      this.date_send_week_4,
      this.date_send_week_5,
      this.use_percen_tage,
      this.id,
      this.lastUpdate,
      this.display_name,
      this.createUid,
      this.createDate,
      this.writeUid,
      this.writeDate});

  factory KPIResponse.fromJson(Map<String, dynamic> json) {
    return _$KPIResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$KPIResponseToJson(this);
}
