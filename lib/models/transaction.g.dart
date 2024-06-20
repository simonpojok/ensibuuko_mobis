// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: (json['id'] as num).toInt(),
      institutionId: (json['institutionId'] as num).toInt(),
      timestamp: (json['timestamp'] as num).toInt(),
      narration: json['narration'] as String,
      amount: (json['amount'] as num).toDouble(),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'institutionId': instance.institutionId,
      'timestamp': instance.timestamp,
      'narration': instance.narration,
      'amount': instance.amount,
    };
