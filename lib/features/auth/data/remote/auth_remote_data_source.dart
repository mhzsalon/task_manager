import 'package:taskmanager/core/firebase/firebase_call_wrapper.dart';
import 'package:taskmanager/core/helper/result.dart';

abstract class AuthRemoteDataSource {
  Future<Result> signUpWithEmailPw(
    String fullName,
    String email,
    String password,
  );
  Future<Result> loginUser(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<Result> signUpWithEmailPw(
    String fullName,
    String email,
    String password,
  ) async {
    return await FirebaseCallWrapper().call.signUpWithEmail(
      fullName,
      email,
      password,
    );
  }

  @override
  Future<Result> loginUser(String email, String password) async {
    return await FirebaseCallWrapper().call.loginUser(email, password);
  }
}
