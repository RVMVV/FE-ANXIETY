part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

//Login
class AuthLoginSuccess extends AuthState {

  final String message;
  final User user; // Tambahkan properti User

  AuthLoginSuccess({required this.message, required this.user});
}

final class AuthLoginError extends AuthState {
  final String message;

  AuthLoginError({required this.message});
}

//Register
final class AuthRegisterSuccess extends AuthState {
  final String message;

  AuthRegisterSuccess({required this.message});
}

final class AuthRegisterError extends AuthState {
  final String message;

  AuthRegisterError(this.message);
}

//Logout
final class AuthLogoutSuccess extends AuthState {
  final String message;

  AuthLogoutSuccess(this.message);
}

final class GetUserSuccess extends AuthState {
  final User user;

  GetUserSuccess(this.user);
}

final class GetUserError extends AuthState {
  final String message;

  GetUserError(this.message);
}

final class UpdateUserSuccess extends AuthState {
  final User user;

  UpdateUserSuccess(this.user);
}

final class UpdateUserError extends AuthState {
  final String message;

  UpdateUserError(this.message);
}