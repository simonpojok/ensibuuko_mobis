import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobis/models/transaction.dart';

part 'financial_institution.g.dart';

@JsonSerializable()
class FinancialInstitution extends Equatable {
  final int id;
  final String name;
  final String phoneNumber;
  final String slogan;
  final List<Transaction> transactions;

  @override
  List<Object?> get props => [name, slogan];

  const FinancialInstitution({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.slogan,
    this.transactions = const [],
  });

  factory FinancialInstitution.fromJson(Map<String, dynamic> json) =>
      _$FinancialInstitutionFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialInstitutionToJson(this);
}
