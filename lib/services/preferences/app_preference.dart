import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
}

@LazySingleton()
class AppPreferences {
  final SharedPreferences _preference;

  AppPreferences(this._preference);
  static const String KEY_AUTH_TOKEN = "KEY_AUTH_TOKEN";
  static const String KEY_REFRESH_TOKEN = "KEY_REFRESH_TOKEN";
  String? accessTokenAnonymous;
  String? get authToken {
    return isLoggedIn
        ? _preference.getString(KEY_AUTH_TOKEN)
        : accessTokenAnonymous;
  }

  bool get isLoggedIn {
    return (_preference.getString(KEY_AUTH_TOKEN)?.isNotEmpty ?? false);
  }

  Future saveAuthToken(response) async {
    await _preference.setString(KEY_AUTH_TOKEN, response?.accessToken ?? '');
    await _preference.setString(
        KEY_REFRESH_TOKEN, response?.refreshToken ?? '');
  }

  void removeAuthToken() {
    _preference.remove(KEY_AUTH_TOKEN);
  }

  void logout() async {
    await _preference.remove(KEY_AUTH_TOKEN);
    await _preference.remove(KEY_REFRESH_TOKEN);
  }
}
