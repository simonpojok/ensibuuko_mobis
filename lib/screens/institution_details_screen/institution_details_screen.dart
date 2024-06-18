import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../models/financial_institution.dart';
import 'financial_transaction_graph.dart';

class InstitutionDetailsScreen extends StatelessWidget {
  static const String path = 'institution-details-screen';

  const InstitutionDetailsScreen(
      {super.key, required this.financialInstitution});

  final FinancialInstitution financialInstitution;

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
                    const SizedBox(height: 20),
                    Text(
                      financialInstitution.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 20,
                          ),
                    ),
                    const SizedBox(height: 20),
                    FinancialTransactionsGraph(
                      transactions: financialInstitution.transactions,
                    ),
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
