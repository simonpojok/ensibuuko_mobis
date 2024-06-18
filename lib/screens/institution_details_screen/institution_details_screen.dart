import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mobis/screens/institution_details_screen/transaction_list_tile.dart';

import '../../models/financial_institution.dart';
import 'financial_transaction_graph.dart';

class InstitutionDetailsScreen extends StatelessWidget {
  static const String path = 'institution-details-screen';

  const InstitutionDetailsScreen(
      {super.key, required this.financialInstitution});

  final FinancialInstitution financialInstitution;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.blue.shade700,
      ),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                color: Colors.blue.shade800,
                child: Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Transactions',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...financialInstitution.transactions.take(6).map(
                          (transaction) => RecentTransactionTile(
                            transaction: transaction,
                          ),
                        )
                  ],
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
      ),
    );
  }
}
