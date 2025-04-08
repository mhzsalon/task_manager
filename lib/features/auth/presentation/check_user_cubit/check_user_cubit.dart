import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/features/auth/domain/usecase/auth_usecase.dart';
part 'check_user_state.dart';

class CheckUserCubit extends Cubit<CheckUserState> {
  final AuthUsecase authUseCase;
  CheckUserCubit(this.authUseCase) : super(CheckUserInitial());

  Future<dynamic> checkUser() async {
    emit(CheckUserLoading());
    String response = await authUseCase.getUserId();
    if (response != "") {
      emit(UserLoggedIn());
    } else {
      emit(UserLoggedOut());
    }
  }

  Future<void> logOutUser() async {
    emit(CheckUserLoading());
    Either<AppException, String> response = await authUseCase.userLogOut();

    response.fold(
      (l) => emit(LogoutFailed(l.errorMessage)),
      (r) => emit(UserLoggedOut()),
    );
  }
}
