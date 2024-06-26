import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction extends Equatable {
  final int id;
  final int institutionId;
  final String phoneNumber;
  final int timestamp;
  final String narration;
  final double amount;

  DateTime get dateTime => DateTime.fromMicrosecondsSinceEpoch(timestamp);

  String get month => DateFormat.MMMM().format(dateTime);

  String get formattedDate => DateFormat.yMMMd().format(dateTime);

  const Transaction({
    required this.phoneNumber,
    required this.id,
    required this.institutionId,
    required this.timestamp,
    required this.narration,
    required this.amount,
  });

  @override
  List<Object?> get props => [id];

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  Transaction copyWith({
    int? id,
    int? institutionId,
    String? phoneNumber,
    int? timestamp,
    String? narration,
    double? amount,
  }) =>
      Transaction(
        id: id ?? this.id,
        institutionId: institutionId ?? this.institutionId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        timestamp: timestamp ?? this.timestamp,
        narration: narration ?? this.narration,
        amount: amount ?? this.amount,
      );
}
