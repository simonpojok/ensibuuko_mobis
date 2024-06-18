import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/models/financial_institution.dart';
import 'package:mobis/models/transaction.dart';

void main() {
  group('FinancialInstitution', () {
    test('props returns the correct list of properties', () {
      const institution = FinancialInstitution(
        name: 'Test Institution',
        slogan: 'Test Slogan',
      );
      expect(institution.props, equals(['Test Institution', 'Test Slogan']));
    });

    test('equality comparison works correctly', () {
      final institution1 = FinancialInstitution(
        name: 'Institution A',
        slogan: 'Slogan A',
        transactions: [
          Transaction(
              id: 1,
              dateTime: DateTime.now(),
              narration: 'Narration 1',
              amount: 100),
        ],
      );

      final institution2 = FinancialInstitution(
        name: 'Institution A',
        slogan: 'Slogan A',
        transactions: [
          Transaction(
              id: 1,
              dateTime: DateTime.now(),
              narration: 'Narration 1',
              amount: 100),
        ],
      );

      const institution3 = FinancialInstitution(
        name: 'Institution B',
        slogan: 'Slogan B',
      );

      expect(institution1, equals(institution2));
      expect(institution1, isNot(equals(institution3)));
    });

    test('toString() returns a string representation of the object', () {
      const institution = FinancialInstitution(
        name: 'Institution X',
        slogan: 'Slogan X',
      );
      expect(institution.toString(), contains('Institution X'));
      expect(institution.toString(), contains('Slogan X'));
    });
  });
}
