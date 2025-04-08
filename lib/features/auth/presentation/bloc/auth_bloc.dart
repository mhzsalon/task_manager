import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/features/auth/domain/usecase/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase authUsecase;
  AuthBloc(this.authUsecase) : super(AuthInitial()) {
    on<SignUpEvent>(_signUpWithEmail);
    on<LoginEvent>(_loginUser);
  }

  FutureOr<void> _signUpWithEmail(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    Either<AppException, String> response = await authUsecase.signUpWithEmailPw(
      event.fullName,
      event.email,
      event.password,
    );
    response.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  FutureOr<void> _loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    Either<AppException, String> response = await authUsecase.loginUser(
      event.email,
      event.password,
    );
    response.fold(
      (l) => emit(AuthError(l.errorMessage)),
      (r) => emit(AuthSuccess(r)),
    );
  }

}
