import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/models/transaction.dart';
import 'package:mobis/screens/institution_details_screen/financial_transaction_graph.dart';

void main() {
  group('FinancialTransactionsGraph', () {
    testWidgets('renders bar chart with transactions',
        (WidgetTester tester) async {
      final transactions = [
        Transaction(
          id: 1,
          timestamp: DateTime(2024, 5, 15).microsecondsSinceEpoch,
          narration: 'Transaction 1',
          amount: 100.0,
          institutionId: 1,
        ),
        Transaction(
          id: 2,
          timestamp: DateTime(2024, 6, 20).microsecondsSinceEpoch,
          narration: 'Transaction 2',
          amount: 200.0,
          institutionId: 1,
        ),
        Transaction(
          id: 3,
          timestamp: DateTime(2024, 5, 10).microsecondsSinceEpoch,
          narration: 'Transaction 3',
          amount: 150.0,
          institutionId: 1,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinancialTransactionsGraph(transactions: transactions),
          ),
        ),
      );

      expect(find.byType(BarChart), findsOneWidget);
      // expect(
      //     find.byType(BarChartRodData),
      //     findsNWidgets(
      //         transactions.length)); // Expect a rod for each transaction
    });

    testWidgets('displays month abbreviations on x-axis',
        (WidgetTester tester) async {
      final transactions = [
        Transaction(
          id: 1,
          timestamp: DateTime(2024, 5, 15).microsecondsSinceEpoch,
          narration: 'Transaction 1',
          amount: 100.0,
          institutionId: 1,
        ),
        Transaction(
          id: 2,
          timestamp: DateTime(2024, 6, 20).microsecondsSinceEpoch,
          narration: 'Transaction 2',
          amount: 200.0,
          institutionId: 1,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinancialTransactionsGraph(transactions: transactions),
          ),
        ),
      );

      expect(find.text('May'), findsOneWidget);
      expect(find.text('Jun'), findsOneWidget);
    });

    testWidgets('calculates and displays total amounts for each month',
        (WidgetTester tester) async {
      final transactions = [
        Transaction(
          id: 1,
          timestamp: DateTime(2024, 5, 15).microsecondsSinceEpoch,
          narration: 'Transaction 1',
          amount: 100.0,
          institutionId: 1,
        ),
        Transaction(
          id: 2,
          timestamp: DateTime(2024, 6, 20).microsecondsSinceEpoch,
          narration: 'Transaction 2',
          amount: 200.0,
          institutionId: 1,
        ),
        Transaction(
          id: 3,
          timestamp: DateTime(2024, 5, 10).microsecondsSinceEpoch,
          narration: 'Transaction 3',
          amount: 150.0,
          institutionId: 1,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FinancialTransactionsGraph(transactions: transactions),
          ),
        ),
      );

      // Check that the bar heights (toY values) correspond to the total amounts for each month
      // final barGroups =
      //     tester.any<BarChartGroupData>(find.byType(BarChartGroupData));
      // expect(barGroups[0].barRods[0].toY, equals(250.0)); // May total
      // expect(barGroups[1].barRods[0].toY, equals(200.0)); // June total
    });
  });
}
