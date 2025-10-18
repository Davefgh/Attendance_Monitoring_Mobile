import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _prefs.setString('accessToken', accessToken);
    await _prefs.setString('refreshToken', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    return _prefs.getString('accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return _prefs.getString('refreshToken');
  }

  static Future<void> clearTokens() async {
    await _prefs.remove('accessToken');
    await _prefs.remove('refreshToken');
  }
}