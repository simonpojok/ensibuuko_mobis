import 'package:equatable/equatable.dart';
import 'package:mobis/models/transaction.dart';

class FinancialInstitution extends Equatable {
  final String name;
  final String slogan;
  final List<Transaction> transactions;

  @override
  List<Object?> get props => [name, slogan];

  const FinancialInstitution({
    required this.name,
    required this.slogan,
    this.transactions = const [],
  });
}
