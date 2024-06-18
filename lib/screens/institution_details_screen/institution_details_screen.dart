import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'bar_chart.dart';

class InstitutionDetailsScreen extends StatelessWidget {
  static const String path = 'institution-details-screen';

  const InstitutionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontSize: 32,
                  ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    BarChartSample1(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(Icons.login, size: 40),
            )
          ],
        ),
      ),
    );
  }
}
