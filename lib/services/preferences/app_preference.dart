import 'dart:convert';

import 'package:hrm/model/response/auth_response.dart';
import 'package:hrm/utils/logger.dart';
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
  static const String PROFILE = "PROFILE";
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
    await _preference.setString(KEY_AUTH_TOKEN, response?.access_token ?? '');
    await _preference.setString(
        KEY_REFRESH_TOKEN, response?.refresh_token ?? '');
  }

  void removeAuthToken() {
    _preference.remove(KEY_AUTH_TOKEN);
  }

  void logout() async {
    await _preference.remove(KEY_AUTH_TOKEN);
    await _preference.remove(KEY_REFRESH_TOKEN);
    await _preference.remove(PROFILE);
  }

  ProfileAuthResponse? get userProfile {
    try {
      var userString = _preference.getString(PROFILE);
      return ProfileAuthResponse.fromJson(json.decode(userString!));
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  saveUserProfile(ProfileAuthResponse? user) async {
    String userProfile;
    try {
      userProfile = json.encode(user?.toJson());
    } catch (e) {
      logger.e(e);
      userProfile = "";
    }
    await _preference.setString(PROFILE, userProfile);
  }

  void removeUserProfile() async {
    _preference.remove(PROFILE);
  }
}
