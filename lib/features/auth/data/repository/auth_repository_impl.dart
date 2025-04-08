import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskmanager/core/helper/exception_helper.dart';
import 'package:taskmanager/core/helper/result.dart';
import 'package:taskmanager/features/auth/data/local/auth_local_data_source.dart';
import 'package:taskmanager/features/auth/data/remote/auth_remote_data_source.dart';
import 'package:taskmanager/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource, this.localDataSource);

  @override
  Future<String> getUserId() async {
    return await localDataSource.getUserId();
  }

  @override
  Future<Either<AppException, String>> signUpWithEmailPw(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      Result response = await authRemoteDataSource.signUpWithEmailPw(
        fullName,
        email,
        password,
      );
      if (response.isSuccess()) {
        User? user = response.getValue();
        localDataSource.saveuserId(user!.uid);
        return Right("Sign Up success");
      } else {
        return Left(
          DefaultException(
            errorMessage: response.getErrorMsg(),
            statusCode: 400,
          ),
        );
      }
    } catch (e) {
      return Left(
        DefaultException(errorMessage: e.toString(), statusCode: 400),
      );
    }
  }

  @override
  Future<Either<AppException, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      Result response = await authRemoteDataSource.loginUser(email, password);
      if (response.isSuccess()) {
        User? user = response.getValue();
        localDataSource.saveuserId(user!.uid);
        return Right("Login success");
      } else {
        return Left(
          DefaultException(
            errorMessage: response.getErrorMsg(),
            statusCode: 400,
          ),
        );
      }
    } catch (e) {
      return Left(
        DefaultException(errorMessage: e.toString(), statusCode: 400),
      );
    }
  }

  @override
  Future<Either<AppException, String>> userLogOut() async {
    try {
      // Result response = await remoteDataSource.firebaseLogout();
      bool logoutSuccess = await localDataSource.removeUserId();

      if (logoutSuccess) {
        return const Right("Logout Success.");
      } else {
        return Left(
          DefaultException(errorMessage: "Logout Failed!", statusCode: 400),
        );
      }
    } catch (e) {
      return Left(
        DefaultException(errorMessage: e.toString(), statusCode: 400),
      );
    }
  }
}
