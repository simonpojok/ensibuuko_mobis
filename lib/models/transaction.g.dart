// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      phoneNumber: json['phoneNumber'] as String,
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
      'phoneNumber': instance.phoneNumber,
      'timestamp': instance.timestamp,
      'narration': instance.narration,
      'amount': instance.amount,
    };
