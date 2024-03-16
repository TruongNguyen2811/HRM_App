import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  final BodyLogin? params;
  LoginRequest({
    this.params,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return _$LoginRequestFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class BodyLogin {
  final String? login;
  final String? password;

  BodyLogin({
    this.login,
    this.password,
  });

  factory BodyLogin.fromJson(Map<String, dynamic> json) {
    return _$BodyLoginFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BodyLoginToJson(this);
}
