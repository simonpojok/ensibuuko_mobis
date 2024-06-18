import 'package:equatable/equatable.dart';

class FinancialInstitution extends Equatable {
  final String name;
  final String slogan;

  @override
  List<Object?> get props => [name, slogan];

  const FinancialInstitution({
    required this.name,
    required this.slogan,
  });
}
