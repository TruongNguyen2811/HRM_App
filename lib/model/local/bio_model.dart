import 'package:freezed_annotation/freezed_annotation.dart';

part 'bio_model.g.dart';

@JsonSerializable()
class BioModel {
  String phoneNumber;
  String password;

  BioModel({required this.phoneNumber, required this.password});

  factory BioModel.fromJson(Map<String, dynamic> json) =>
      _$BioModelFromJson(json);

  Map<String, dynamic> toJson() => _$BioModelToJson(this);
}
