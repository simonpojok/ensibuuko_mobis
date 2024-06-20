// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_institution.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialInstitution _$FinancialInstitutionFromJson(
        Map<String, dynamic> json) =>
    FinancialInstitution(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      slogan: json['slogan'] as String,
      transactions: (json['transactions'] as List<dynamic>?)
              ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FinancialInstitutionToJson(
        FinancialInstitution instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slogan': instance.slogan,
      'transactions': instance.transactions,
    };
