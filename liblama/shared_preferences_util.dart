import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPreferencesUtil {
  static Future<void> saveUser(String email, Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(email, jsonEncode(user));
  }

  static Future<Map<String, dynamic>?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(email);
    if (userString != null) {
      return jsonDecode(userString) as Map<String, dynamic>;
    }
    return null;
  }

  static Future<void> saveToken(String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', email);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
  }
}
