import 'package:json_annotation/json_annotation.dart';

part 'success_message_response.g.dart';

@JsonSerializable()
class SuccessMessage {
  bool? success;
  String? message;
  bool? is_success;

  SuccessMessage({
    this.success,
    this.message,
    this.is_success,
  });

  factory SuccessMessage.fromJson(Map<String, dynamic> json) {
    return _$SuccessMessageFromJson(json);
  }

  Map<String, dynamic> toJson() => _$SuccessMessageToJson(this);
}
