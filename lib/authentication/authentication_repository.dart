import 'dart:isolate';
import 'dart:math';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobis/models/financial_institution.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/transaction.dart';
import '../provider/financial_institution_provider.dart';
import '../provider/transaction_provider.dart';

const _phoneNumber = 'phone_number';
const _knownUsers = 'known_users';

class AuthenticationRepository {
  static const _usersPhoneNumbers = ['+256788123456', '+256700123456'];
  final SharedPreferences sharedPreferences;
  final FinancialInstitutionProvider financialInstitutionProvider;
  final TransactionProvider transactionProvider;

  const AuthenticationRepository({
    required this.sharedPreferences,
    required this.financialInstitutionProvider,
    required this.transactionProvider,
  });

  Future loginUserWithPhoneNumber(String phoneNumber) async {
    if (![
      ..._usersPhoneNumbers,
      ...(sharedPreferences.getStringList(_knownUsers) ?? [])
    ].contains(phoneNumber)) {
      throw Exception('Unknown Error');
    }
    await sharedPreferences.setString(_phoneNumber, phoneNumber);
    var rootToken = RootIsolateToken.instance!;

    await compute((rootToken) async {
      BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

      final financialInstitution = _generateFinancialInstitution()
          .map(
            (institution) => institution.copyWith(
              phoneNumber: phoneNumber,
              transactions: institution.transactions
                  .map((transaction) => transaction.copyWith(
                        phoneNumber: phoneNumber,
                        institutionId: institution.id,
                      ))
                  .toList(),
            ),
          )
          .toList();
      await financialInstitutionProvider
          .insertFinancialInstitutions(financialInstitution);
    }, rootToken);
  }

  String getPhoneNumber() {
    return sharedPreferences.getString(_phoneNumber) ?? '';
  }

  Future signupUserWithPhoneNumber(String phoneNumber) async {
    await sharedPreferences.setStringList(
        _knownUsers,
        {
          ..._usersPhoneNumbers,
          ...(sharedPreferences.getStringList(_knownUsers) ?? []),
          phoneNumber
        }.map((item) => item.toString()).toList());

    await loginUserWithPhoneNumber(phoneNumber);
  }

  List<FinancialInstitution> _generateFinancialInstitution() {
    final random = Random();

    return [
      FinancialInstitution(
        id: 1 + random.nextInt(1000),
        name: 'Rukiga SACCO',
        slogan: 'Save for a better future',
        transactions: _generateTransactions(1),
        phoneNumber: '',
      ),
      FinancialInstitution(
        id: 4 + random.nextInt(1000),
        name: 'KINA SACCO',
        slogan: "Kulw'okweterekera n'okwewola",
        transactions: _generateTransactions(2),
        phoneNumber: '',
      ),
      FinancialInstitution(
        id: 100 + random.nextInt(1000),
        name: 'Deed Microfinance',
        slogan: 'We care about your growth',
        transactions: _generateTransactions(3),
        phoneNumber: '',
      ),
    ];
  }

  List<Transaction> _generateTransactions(int id) {
    var faker = Faker();
    return List.generate(60, (index) {
      return Transaction(
        id: DateTime.now().microsecondsSinceEpoch,
        timestamp: faker.date
            .dateTime(minYear: 2023, maxYear: 2024)
            .microsecondsSinceEpoch,
        narration: faker.lorem.words(2).join(' '),
        amount: faker.randomGenerator.decimal(scale: 100, min: 100),
        institutionId: id,
        phoneNumber: '',
      );
    });
  }
}

extension AuthenticationRepositoryContext on BuildContext {
  AuthenticationRepository getAuthenticationRepository() {
    return RepositoryProvider.of<AuthenticationRepository>(this);
  }
}
