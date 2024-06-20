import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../authentication/authentication_repository.dart';

part 'signup_screen_state.dart';

class SignupScreenCubit extends Cubit<SignupScreenState> {
  SignupScreenCubit(this.sharedPreferenceRepository)
      : super(SignupScreenInitial());

  final AuthenticationRepository sharedPreferenceRepository;

  void loginUserWithPhoneNumber(String phoneNumber) {
    emit(SignupScreenLoading());
    sharedPreferenceRepository
        .loginUserWithPhoneNumber(phoneNumber)
        .then((response) => emit(SignupScreenSuccess()))
        .catchError((error, stack) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stack);
      emit(const SignupScreenError('Unknown Error'));
    });
  }
}
