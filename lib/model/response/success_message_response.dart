import 'package:json_annotation/json_annotation.dart';

part 'success_message_response.g.dart';

@JsonSerializable()
class SuccessMessage {
  bool? success;
  String? message;

  SuccessMessage({
    this.success,
    this.message,
  });

  factory SuccessMessage.fromJson(Map<String, dynamic> json) {
    return _$SuccessMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SuccessMessageToJson(this);
}
