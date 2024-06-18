import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/models/transaction.dart';
import 'package:mobis/screens/institution_details_screen/transaction_list_tile.dart';

void main() {
  group('RecentTransactionTile', () {
    testWidgets('renders transaction details correctly',
        (widgetTestertester) async {
      final transaction = Transaction(
        id: 1,
        dateTime: DateTime(2024, 5, 15),
        narration: 'test narration',
        amount: 100.0,
      );

      await widgetTestertester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RecentTransactionTile(transaction: transaction),
          ),
        ),
      );

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('Test narration'), findsOneWidget);
      expect(find.text('May 15, 2024'), findsOneWidget);
    });

    test('StringCasingExtension works correctly', () {
      expect('test string'.toCapitalized(), equals('Test string'));
      expect('multiple words'.toTitleCase(), equals('Multiple Words'));
      expect(''.toCapitalized(), isEmpty);
    });
  });
}
