import 'dart:convert';

import '../model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  final SharedPreferences _preferences;

  AppPref(this._preferences);

  bool get isLogin => _preferences.getBool('isLogin') ?? false;

  set isLogin(bool value) => _preferences.setBool('isLogin', value);

  bool get isUserLogin => _preferences.getBool('isUserLogin') ?? false;
  set isUserLogin(bool value) => _preferences.setBool('isUserLogin', value);

  bool get isFirstOpen => _preferences.getBool('isFirstOpen') ?? true;
  set isFirstOpen(bool value) => _preferences.setBool('isFirstOpen', value);

  bool get isPrefOpen => _preferences.getBool('isPrefOpen') ?? false;
  set isPrefOpen(bool value) => _preferences.setBool('isPrefOpen', value);

  bool get isOnboardingOpen => _preferences.getBool('isOnboardingOpen') ?? false;
  set isOnboardingOpen(bool value) => _preferences.setBool('isOnboardingOpen', value);

  String get accessToken => _preferences.getString('accessToken') ?? "";
  set accessToken(String token) => _preferences.setString('accessToken', token);

  String get tncLink => _preferences.getString('tncLink') ?? "";
  set tncLink(String tncLink) => _preferences.setString('tncLink', tncLink);

  String get privacyLink => _preferences.getString('privacyLink') ?? "";
  set privacyLink(String privacyLink) => _preferences.setString('privacyLink', privacyLink);


  /// clear preference
  Future<void> clear() async {
    await _preferences.clear();
  }
}
