import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mobis/models/transaction.dart';

import '../models/financial_institution.dart';

class FinancialInstitutionRepository {
  final random = Random();

  Future<List<FinancialInstitution>> getSupportedFinancialInstitutions() async {
    return [
      FinancialInstitution(
        id: 1,
        name: 'Rukiga SACCO',
        slogan: 'Save for a better future',
        transactions: _generateTransactions(1),
      ),
      FinancialInstitution(
        id: 2,
        name: 'KINA SACCO',
        slogan: "Kulw'okweterekera n'okwewola",
        transactions: _generateTransactions(2),
      ),
      FinancialInstitution(
        id: 3,
        name: 'Deed Microfinance',
        slogan: 'We care about your growth',
        transactions: _generateTransactions(3),
      ),
    ];
  }

  List<Transaction> _generateTransactions(int id) {
    var faker = Faker();
    return List.generate(60, (index) {
      return Transaction(
        id: index + 1,
        timestamp: faker.date
            .dateTime(minYear: 2023, maxYear: 2024)
            .microsecondsSinceEpoch,
        narration: faker.lorem.words(2).join(' '),
        amount: faker.randomGenerator.decimal(scale: 100, min: 100),
        institutionId: id,
      );
    });
  }
}
