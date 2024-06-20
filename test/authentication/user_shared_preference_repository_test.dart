import 'package:flutter_test/flutter_test.dart';
import 'package:mobis/authentication/authentication_repository.dart';
import 'package:mobis/provider/financial_institution_provider.dart';
import 'package:mobis/provider/transaction_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _phoneNumber = 'phone_number';
const validPhoneNumber = '+256788123456';

class MockSharedPreferences extends Fake implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late AuthenticationRepository repository;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    repository = AuthenticationRepository(
      sharedPreferences: mockSharedPreferences,
      financialInstitutionProvider:
          FinancialInstitutionProvider(TransactionProvider()),
      transactionProvider: TransactionProvider(),
    );
  });

  group('UserSharedPreferenceRepository', () {
    test('loginUserWithPhoneNumber saves phone number for valid numbers',
        () async {
      when(mockSharedPreferences.setString(_phoneNumber, validPhoneNumber))
          .thenAnswer((_) async => true);

      await repository.loginUserWithPhoneNumber(validPhoneNumber);

      verify(mockSharedPreferences.setString(_phoneNumber, validPhoneNumber));
    });

    test('loginUserWithPhoneNumber throws exception for invalid numbers',
        () async {
      const invalidPhoneNumber = '+1234567890';

      expect(
        () async => repository.loginUserWithPhoneNumber(invalidPhoneNumber),
        throwsA(isA<Exception>()),
      );
    });

    test('getPhoneNumber returns saved phone number', () {
      const savedPhoneNumber = '+256700123456';
      when(mockSharedPreferences.getString(_phoneNumber))
          .thenReturn(savedPhoneNumber);

      final result = repository.getPhoneNumber();

      expect(result, equals(savedPhoneNumber));
    });

    test('getPhoneNumber returns empty string if no phone number is saved', () {
      when(mockSharedPreferences.getString(_phoneNumber)).thenReturn(null);

      final result = repository.getPhoneNumber();

      expect(result, isEmpty);
    });
  });
}
