part of 'signup_screen_cubit.dart';

sealed class SignupScreenState extends Equatable {
  const SignupScreenState();
}

final class SignupScreenInitial extends SignupScreenState {
  @override
  List<Object> get props => [];
}

final class SignupScreenLoading extends SignupScreenState {
  @override
  List<Object> get props => [];
}

final class SignupScreenSuccess extends SignupScreenState {
  @override
  List<Object> get props => [];
}

final class SignupScreenError extends SignupScreenState {
  final String errorMessage;

  const SignupScreenError(this.errorMessage);

  @override
  List<Object> get props => [];
}
