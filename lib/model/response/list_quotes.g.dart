// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_quotes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListQuotes _$ListQuotesFromJson(Map<String, dynamic> json) => ListQuotes(
      result: (json['result'] as List<dynamic>?)
          ?.map((e) => Quotes.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListQuotesToJson(ListQuotes instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Quotes _$QuotesFromJson(Map<String, dynamic> json) => Quotes(
      id: json['id'] as num?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      probationary_contract_termination_date:
          json['probationary_contract_termination_date'] as bool?,
      date_sign: json['date_sign'] as String?,
      data: json['data'] as List<dynamic>?,
    );

Map<String, dynamic> _$QuotesToJson(Quotes instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'data': instance.data,
      'probationary_contract_termination_date':
          instance.probationary_contract_termination_date,
      'date_sign': instance.date_sign,
    };
