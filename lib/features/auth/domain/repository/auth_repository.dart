import 'package:dartz/dartz.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';

abstract class AuthRepository {
  Future<Either<AppException, String>> signUpWithEmailPw(
    String fullName,
    String email,
    String password,
  );
  Future<Either<AppException, String>> loginUser(String email, String password);
  Future<Either<AppException, String>> userLogOut();
  Future<String> getUserId();
}
