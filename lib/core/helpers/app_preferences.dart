import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static bool? getInitialization() {
    return _instance.preferences.getBool("init");
  }

  static Future setInitialization(bool value) async {
    _instance.preferences.setBool("init", value);
  }
}
