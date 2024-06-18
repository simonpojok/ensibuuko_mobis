import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobis/storage/user_shared_preference_repository.dart';

part 'login_screen_state.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  LoginScreenCubit(this.sharedPreferenceRepository)
      : super(LoginScreenInitial());

  final UserSharedPreferenceRepository sharedPreferenceRepository;

  void loginUserWithPhoneNumber(String phoneNumber) {
    emit(LoginScreenLoading());
    sharedPreferenceRepository
        .loginUserWithPhoneNumber(phoneNumber)
        .then((response) => emit(LoginScreenSuccess()))
        .catchError((error, stack) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stack);
      emit(const LoginScreenError('Unknown Error'));
    });
  }
}
