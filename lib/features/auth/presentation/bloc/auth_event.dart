part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class SignUpEvent extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  const SignUpEvent(this.fullName, this.email, this.password);
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent(this.email, this.password);
}
