import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Transaction extends Equatable {
  final int id;
  final DateTime dateTime;
  final String narration;
  final double amount;

  String get month => DateFormat.MMMM().format(dateTime);

  const Transaction({
    required this.id,
    required this.dateTime,
    required this.narration,
    required this.amount,
  });

  @override
  List<Object?> get props => [id];
}
