import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/models/financial_institution.dart';
import 'package:mobis/models/transaction.dart';

void main() {
  group('FinancialInstitution', () {
    test('props returns the correct list of properties', () {
      const institution = FinancialInstitution(
        name: 'Test Institution',
        slogan: 'Test Slogan',
        id: 1,
        phoneNumber: '',
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
            timestamp: DateTime.now().microsecondsSinceEpoch,
            narration: 'Narration 1',
            amount: 100,
            institutionId: 1,
            phoneNumber: '',
          ),
        ],
        id: 1,
        phoneNumber: '',
      );

      final institution2 = FinancialInstitution(
        name: 'Institution A',
        slogan: 'Slogan A',
        id: 1,
        transactions: [
          Transaction(
            id: 1,
            timestamp: DateTime.now().microsecondsSinceEpoch,
            narration: 'Narration 1',
            amount: 100,
            institutionId: 1,
            phoneNumber: '',
          ),
        ],
        phoneNumber: '',
      );

      const institution3 = FinancialInstitution(
        name: 'Institution B',
        slogan: 'Slogan B',
        id: 1,
        phoneNumber: '',
      );

      expect(institution1, equals(institution2));
      expect(institution1, isNot(equals(institution3)));
    });

    test('toString() returns a string representation of the object', () {
      const institution = FinancialInstitution(
        name: 'Institution X',
        slogan: 'Slogan X',
        id: 1,
        phoneNumber: '',
      );
      expect(institution.toString(), contains('Institution X'));
      expect(institution.toString(), contains('Slogan X'));
    });
  });
}
