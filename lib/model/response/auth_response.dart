import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  final ProfileAuthResponse? data;
  AuthResponse({
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return _$AuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class ProfileAuthResponse {
  final num? user_id;
  final num? department_id;
  final String? display_name;
  final num? company_id;
  final String? company_name;
  final String? access_token;
  final dynamic expires_in;
  final String? refresh_token;
  final dynamic refresh_expires_in;
  final bool? is_general_manager;
  final bool? is_head_of_department;
  final bool? is_department_secretary;
  final bool? employee_ho;
  final bool? is_administrative;
  final num? employee_id;

  ProfileAuthResponse({
    this.user_id,
    this.department_id,
    this.display_name,
    this.company_id,
    this.access_token,
    this.company_name,
    this.employee_ho,
    this.employee_id,
    this.expires_in,
    this.is_administrative,
    this.is_department_secretary,
    this.is_general_manager,
    this.is_head_of_department,
    this.refresh_expires_in,
    this.refresh_token,
  });

  factory ProfileAuthResponse.fromJson(Map<String, dynamic> json) {
    return _$ProfileAuthResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProfileAuthResponseToJson(this);
}
