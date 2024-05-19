import 'package:json_annotation/json_annotation.dart';

part 'list_quotes.g.dart';

@JsonSerializable()
class ListQuotes {
  List<Quotes>? result;

  ListQuotes({
    this.result,
  });

  factory ListQuotes.fromJson(Map<String, dynamic> json) {
    return _$ListQuotesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ListQuotesToJson(this);
}

@JsonSerializable()
class Quotes {
  num? id;
  String? name;
  String? type;
  List<dynamic>? data;
  bool? probationary_contract_termination_date;
  String? date_sign;

  Quotes({
    this.id,
    this.name,
    this.type,
    this.probationary_contract_termination_date,
    this.date_sign,
    this.data,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return _$QuotesFromJson(json);
  }

  Map<String, dynamic> toJson() => _$QuotesToJson(this);
}
