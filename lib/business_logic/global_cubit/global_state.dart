part of 'global_cubit.dart';

@immutable
abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class DangerChangePasswordVisibilityState extends GlobalState {}

class LoginLoadingState extends GlobalState {}

class LoginSuccessState extends GlobalState {}

class LoginErrorState extends GlobalState {
  final String error;
  LoginErrorState(this.error);
}

class RegisterLoadingState extends GlobalState {}

class RegisterSuccessState extends GlobalState {}

class RegisterErrorState extends GlobalState {
  final String error;
  RegisterErrorState(this.error);
}
