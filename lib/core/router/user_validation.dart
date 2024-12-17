import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  
  final GetStorage _storage;
  
  TokenStorage(): _storage = GetStorage();
  
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(_accessTokenKey, accessToken);
    await _storage.write(_refreshTokenKey, refreshToken);
  }
  
  Future<void> clearTokens() async {
    await _storage.remove(_accessTokenKey);
    await _storage.remove(_refreshTokenKey);
  }
  
  String? getAccessToken() => _storage.read(_accessTokenKey);
  String? getRefreshToken() => _storage.read(_refreshTokenKey);
  
  bool get hasTokens => getAccessToken() != null && getRefreshToken() != null;
}
