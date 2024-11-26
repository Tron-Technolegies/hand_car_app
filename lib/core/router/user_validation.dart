import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthManager {
  static const String _authTokenKey = 'auth_token';
  static const String _userDataKey = 'user_data';

  // Save authentication token
  static Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_authTokenKey, token);
  }

  // Save user data
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, json.encode(userData));
  }

  // Get authentication token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_authTokenKey);
  }

  // Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    return userDataString != null ? json.decode(userDataString) : null;
  }

  // Logout method
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authTokenKey);
    await prefs.remove(_userDataKey);
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_authTokenKey) && 
           (prefs.getString(_authTokenKey)?.isNotEmpty ?? false);
  }
}