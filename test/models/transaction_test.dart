import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/models/transaction.dart';

void main() {
  group('Transaction', () {
    test('props returns the correct list of properties', () {
      final transaction = Transaction(
        id: 1,
        dateTime: DateTime.now(),
        narration: 'Test Narration',
        amount: 100.0,
      );
      expect(transaction.props, equals([1]));
    });

    test('equality comparison works correctly', () {
      final transaction1 = Transaction(
        id: 1,
        dateTime: DateTime.now(),
        narration: 'Narration 1',
        amount: 100.0,
      );

      final transaction2 = Transaction(
        id: 1,
        dateTime: DateTime.now(),
        narration: 'Narration 1',
        amount: 100.0,
      );

      final transaction3 = Transaction(
        id: 2,
        dateTime: DateTime.now(),
        narration: 'Narration 2',
        amount: 200.0,
      );

      expect(transaction1, equals(transaction2));
      expect(transaction1, isNot(equals(transaction3)));
    });

    test('month returns the correct month name', () {
      final transaction = Transaction(
        id: 1,
        dateTime: DateTime(2024, 5, 15), // May 15, 2024
        narration: 'Test Narration',
        amount: 100.0,
      );
      expect(transaction.month, equals('May'));
    });

    test('formattedDate returns the date in the correct format', () {
      final transaction = Transaction(
        id: 1,
        dateTime: DateTime(2024, 5, 15), // May 15, 2024
        narration: 'Test Narration', amount: 100.0,
      );
      expect(transaction.formattedDate, equals('May 15, 2024'));
    });
  });
}
