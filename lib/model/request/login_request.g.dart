// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      params: json['params'] == null
          ? null
          : BodyLogin.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'params': instance.params,
    };

BodyLogin _$BodyLoginFromJson(Map<String, dynamic> json) => BodyLogin(
      login: json['login'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$BodyLoginToJson(BodyLogin instance) => <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };
