part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AppStarted extends AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  const AuthLogin({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class AuthLogout extends AuthEvent {}

final class AuthRegister extends AuthEvent {
  final RegisterUserData data;

  const AuthRegister({required this.data});

  @override
  List<Object> get props => [data];
}
