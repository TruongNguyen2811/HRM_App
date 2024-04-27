import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'jsonrpc')
  dynamic jsonrpc;
  @JsonKey(name: 'id')
  dynamic id;
  @JsonKey(name: 'result')
  T result;
  @JsonKey(name: 'error')
  dynamic error;

  BaseResponse({this.jsonrpc, this.id, required this.result});

  factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
