// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessMessage _$SuccessMessageFromJson(Map<String, dynamic> json) =>
    SuccessMessage(
      success: json['success'] as bool?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SuccessMessageToJson(SuccessMessage instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
