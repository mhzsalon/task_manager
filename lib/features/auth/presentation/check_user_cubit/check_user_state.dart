part of 'check_user_cubit.dart';

sealed class CheckUserState extends Equatable {
  const CheckUserState();

  @override
  List<Object> get props => [];
}

final class CheckUserInitial extends CheckUserState {}

final class CheckUserLoading extends CheckUserState {}

final class UserLoggedIn extends CheckUserState {}

final class UserLoggedOut extends CheckUserState {}

final class LogoutFailed extends CheckUserState {
  final String errorMessage;

  const LogoutFailed(this.errorMessage);
}
