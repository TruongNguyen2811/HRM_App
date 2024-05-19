// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessMessage _$SuccessMessageFromJson(Map<String, dynamic> json) =>
    SuccessMessage(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      is_success: json['is_success'] as bool?,
    );

Map<String, dynamic> _$SuccessMessageToJson(SuccessMessage instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'is_success': instance.is_success,
    };
