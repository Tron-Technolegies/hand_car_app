// import 'package:get_storage/get_storage.dart';

// class AuthTokenService {
//   static final GetStorage _storage = GetStorage();
//   static const String _tokenKey = 'auth_token';

//   static Future<void> saveToken(String token) async {
//     await _storage.write(_tokenKey, token);
//   }

//   static String? getToken() {
//     return _storage.read<String>(_tokenKey);
//   }

//   static Future<void> removeToken() async {
//     await _storage.remove(_tokenKey);
//   }
// }

import 'package:shared_preferences/shared_preferences.dart';

class AuthTokenService {
  static const String _tokenKey = 'auth_token';
  
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }
  
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }
  
  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}