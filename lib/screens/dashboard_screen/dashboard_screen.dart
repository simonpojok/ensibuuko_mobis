import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mobis/storage/user_shared_preference_repository.dart';
import 'package:intl_phone_number_input/src/utils/phone_number/phone_number_util.dart';

import '../../models/financial_institution.dart';
import '../institution_details_screen/institution_details_screen.dart';
import 'dashboard_screen_cubit.dart';

class DashboardScreen extends StatefulWidget {
  static const String path = '/';

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _userPhoneNumber = '';

  @override
  void initState() {
    context.read<DashboardScreenCubit>().getFinancialInstitutions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade800,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              'Welcome',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 36,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 40),
            Text(
              context.read<UserSharedPreferenceRepository>().getPhoneNumber(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                  ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      'Select the organization to proceed to\nlogin',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    BlocBuilder(
                      builder: (context, state) {
                        List<FinancialInstitution> financialInstitutions =
                            state is DashboardScreenSuccess
                                ? state.financialInstitutions
                                : [];

                        // TODO: Use ListView incase the number of institution are more than 3

                        return Column(
                          children: financialInstitutions
                              .map(
                                (item) => OrganizationListItem(
                                  name: item.name,
                                  slogan: item.slogan,
                                  onTap: () {
                                    context.go(
                                      '/${InstitutionDetailsScreen.path}',
                                      extra: item,
                                    );
                                  },
                                ),
                              )
                              .toList(),
                        );
                      },
                      bloc: context.read<DashboardScreenCubit>(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrganizationListItem extends StatelessWidget {
  final String name;
  final String slogan;
  final VoidCallback onTap;

  const OrganizationListItem({
    super.key,
    required this.name,
    required this.slogan,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.shade100,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade400,
                radius: 24,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                  ),
                  Text(
                    slogan,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 14,
                          color: Colors.grey.shade700,
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
