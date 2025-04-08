import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<bool> saveuserId(String uid);
  Future<String> getUserId();
  Future<bool> removeUserId();
}

class AuthLocalDataSourceImpl extends AuthLocalDataSource {
  final SharedPreferences preferences;
  AuthLocalDataSourceImpl(this.preferences);

  @override
  Future<String> getUserId() async {
    return preferences.getString("USER_ID") ?? "";
  }

  @override
  Future<bool> saveuserId(String uid) async {
    return preferences.setString("USER_ID", uid);
  }

  @override
  Future<bool> removeUserId() async {
    return preferences.remove("USER_ID");
  }
}
