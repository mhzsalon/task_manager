import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase(this.authRepository);

  Future<Either<AppException, String>> signUpWithEmailPw(
    String fullName,
    String email,
    String password,
  ) async {
    return await authRepository.signUpWithEmailPw(fullName, email, password);
  }

  Future<Either<AppException, String>> loginUser(
    String email,
    String password,
  ) async {
    return await authRepository.loginUser(email, password);
  }

  Future<String> getUserId() async {
    return await authRepository.getUserId();
  }

  Future<Either<AppException, String>> userLogOut() async {
    return await authRepository.userLogOut();
  }
}
