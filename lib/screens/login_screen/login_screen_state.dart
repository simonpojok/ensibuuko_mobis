part of 'login_screen_cubit.dart';

sealed class LoginScreenState extends Equatable {
  const LoginScreenState();
}

final class LoginScreenInitial extends LoginScreenState {
  @override
  List<Object> get props => [];
}

final class LoginScreenLoading extends LoginScreenState {
  @override
  List<Object> get props => [];
}

final class LoginScreenSuccess extends LoginScreenState {
  @override
  List<Object> get props => [];
}

final class LoginScreenError extends LoginScreenState {
  final String errorMessage;

  const LoginScreenError(this.errorMessage);

  @override
  List<Object> get props => [];
}
