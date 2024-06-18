import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/remote/financial_institution_repository.dart';

void main() {
  late FinancialInstitutionRepository repository;

  setUp(() {
    repository = FinancialInstitutionRepository();
  });

  group('FinancialInstitutionRepository', () {
    test('getSupportedFinancialInstitutions returns a non-empty list',
        () async {
      final institutions = await repository.getSupportedFinancialInstitutions();
      expect(institutions, isNotEmpty);
    });

    test('each FinancialInstitution has a name, slogan, and transactions',
        () async {
      final institutions = await repository.getSupportedFinancialInstitutions();
      for (final institution in institutions) {
        expect(institution.name, isNotEmpty);
        expect(institution.slogan, isNotEmpty);
        expect(institution.transactions, isNotEmpty);
      }
    });

    test('each FinancialInstitution has 60 transactions', () async {
      final institutions = await repository.getSupportedFinancialInstitutions();
      for (final institution in institutions) {
        expect(institution.transactions.length, equals(60));
      }
    });

    test('transaction amounts are within expected range', () async {
      final institutions = await repository.getSupportedFinancialInstitutions();
      for (final institution in institutions) {
        for (final transaction in institution.transactions) {
          expect(transaction.amount, greaterThanOrEqualTo(100));
        }
      }
    });
  });
}
