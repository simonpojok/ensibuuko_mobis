import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

import '../../models/transaction.dart';

class FinancialTransactionsGraph extends StatefulWidget {
  const FinancialTransactionsGraph({super.key, required this.transactions});

  final List<Transaction> transactions;

  @override
  State<StatefulWidget> createState() => FinancialTransactionsGraphState();
}

class FinancialTransactionsGraphState
    extends State<FinancialTransactionsGraph> {
  List<String> months = [];

  @override
  Widget build(BuildContext context) {
    final groupedData = groupBy(
        widget.transactions.sorted((a, b) => a.dateTime.compareTo(b.dateTime)),
        (item) => item.month);

    months = groupedData.keys.map((item) => item.substring(0, 3)).toList();
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(10),
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: false,
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 20,
                    child: Transform.rotate(
                      angle: -(22 / 7) / 12.0,
                      child: Text(
                        months.isNotEmpty ? months.removeAt(0) : '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
                reservedSize: 38,
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: groupedData.keys.map((month) {
            final progress =
                groupedData[month]?.map((item) => item.amount).sum.toInt() ?? 0;
            return BarChartGroupData(
              x: progress,
              barRods: [
                BarChartRodData(
                  toY: progress.toDouble(),
                  color: Colors.green,
                  width: 10,
                  backDrawRodData: BackgroundBarChartRodData(
                    show: true,
                    toY: 20,
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
              showingTooltipIndicators: [],
            );
          }).toList(),
          gridData: const FlGridData(show: false),
        ),
      ),
    );
  }
}
