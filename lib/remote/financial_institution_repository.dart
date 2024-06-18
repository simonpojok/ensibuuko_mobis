import 'dart:math';

import 'package:faker/faker.dart';
import 'package:mobis/models/transaction.dart';

import '../models/financial_institution.dart';

class FinancialInstitutionRepository {
  final random = Random();

  Future<List<FinancialInstitution>> getSupportedFinancialInstitutions() async {
    return [
      FinancialInstitution(
        name: 'Rukiga SACCO',
        slogan: 'Save for a better future',
        transactions: _generateTransactions(),
      ),
      FinancialInstitution(
        name: 'KINA SACCO',
        slogan: "Kulw'okweterekera n'okwewola",
        transactions: _generateTransactions(),
      ),
      FinancialInstitution(
        name: 'Deed Microfinance',
        slogan: 'We care about your growth',
        transactions: _generateTransactions(),
      ),
    ];
  }

  List<Transaction> _generateTransactions() {
    var faker = Faker();
    return List.generate(60, (index) {
      return Transaction(
        id: index + 1,
        dateTime: faker.date.dateTime(minYear: 2023, maxYear: 2024),
        narration: faker.lorem.words(2).join(' '),
        amount: faker.randomGenerator.decimal(scale: 100, min: 100),
      );
    });
  }
}
