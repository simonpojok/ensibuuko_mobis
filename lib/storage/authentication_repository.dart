import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _phoneNumber = 'phone_number';

class AuthenticationRepository {
  static const _usersPhoneNumbers = ['+256788123456', '+256700123456'];
  final SharedPreferences sharedPreferences;

  const AuthenticationRepository({required this.sharedPreferences});

  Future loginUserWithPhoneNumber(String phoneNumber) async {
    if (!_usersPhoneNumbers.contains(phoneNumber)) {
      throw Exception('Unknown Error');
    }
    await sharedPreferences.setString(_phoneNumber, phoneNumber);
  }

  String getPhoneNumber() {
    return sharedPreferences.getString(_phoneNumber) ?? '';
  }

  Future signupUserWithPhoneNumber(String phoneNumber) async {
    if (!_usersPhoneNumbers.contains(phoneNumber)) {
      throw Exception('Unknown Error');
    }
    await sharedPreferences.setString(_phoneNumber, phoneNumber);
  }
}

extension AuthenticationRepositoryContext on BuildContext {
  AuthenticationRepository getAuthenticationRepository() {
    return RepositoryProvider.of<AuthenticationRepository>(this);
  }
}
