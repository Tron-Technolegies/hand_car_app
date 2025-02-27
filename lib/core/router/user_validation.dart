import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:synchronized/synchronized.dart';

class TokenStorageException implements Exception {
  final String message;
  TokenStorageException(this.message);
  @override
  String toString() => message;
}

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _loginTimestampKey = 'login_timestamp';
  static const int _oneMonthInMillis = 30 * 24 * 60 * 60 * 1000; // 30 days in milliseconds
  
  final GetStorage _storage;
  static TokenStorage? _instance;
  static final Lock _lock = Lock();

  factory TokenStorage() {
    if (_instance == null) {
      _lock.synchronized(() {
        _instance ??= TokenStorage._internal();
      });
    }
    return _instance!;
  }

  TokenStorage._internal() : _storage = GetStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      if (accessToken.isEmpty || refreshToken.isEmpty) {
        throw TokenStorageException('Tokens cannot be empty');
      }

      final loginTimestamp = DateTime.now().millisecondsSinceEpoch;

      await _lock.synchronized(() async {
        await Future.wait([
          _storage.write(_accessTokenKey, _encryptToken(accessToken)),
          _storage.write(_refreshTokenKey, _encryptToken(refreshToken)),
          _storage.write(_loginTimestampKey, loginTimestamp),
        ]);
      });

      log('Tokens and login timestamp saved successfully');
    } catch (e) {
      log('Error saving tokens: $e');
      await clearTokens();
      throw TokenStorageException('Failed to save tokens: $e');
    }
  }

  String? getAccessToken() {
    try {
      final encryptedToken = _storage.read<String>(_accessTokenKey);
      if (encryptedToken == null) return null;
      return _decryptToken(encryptedToken);
    } catch (e) {
      log('Error getting access token: $e');
      return null;
    }
  }

  String? getRefreshToken() {
    try {
      final encryptedToken = _storage.read<String>(_refreshTokenKey);
      if (encryptedToken == null) return null;
      return _decryptToken(encryptedToken);
    } catch (e) {
      log('Error getting refresh token: $e');
      return null;
    }
  }

  String _encryptToken(String token) => base64.encode(utf8.encode(token));

  String _decryptToken(String encryptedToken) {
    try {
      return utf8.decode(base64.decode(encryptedToken));
    } catch (e) {
      log('Error decrypting token: $e');
      throw TokenStorageException('Failed to decrypt token');
    }
  }

  Future<void> clearTokens() async {
    try {
      await _lock.synchronized(() async {
        await Future.wait([
          _storage.remove(_accessTokenKey),
          _storage.remove(_refreshTokenKey),
          _storage.remove(_loginTimestampKey),
        ]);
      });
      log('Tokens and login timestamp cleared successfully');
    } catch (e) {
      log('Error clearing tokens: $e');
      throw TokenStorageException('Failed to clear tokens: $e');
    }
  }

  bool get hasValidLoginPeriod {
    try {
      final loginTimestamp = _storage.read<int>(_loginTimestampKey);
      if (loginTimestamp == null) return false;

      final currentTime = DateTime.now().millisecondsSinceEpoch;
      return (currentTime - loginTimestamp) <= _oneMonthInMillis;
    } catch (e) {
      log('Error checking login period validity: $e');
      return false;
    }
  }

  bool get hasValidTokens {
    try {
      final accessToken = getAccessToken();
      final refreshToken = getRefreshToken();
      return accessToken != null && refreshToken != null && hasValidLoginPeriod;
    } catch (e) {
      log('Error checking token validity: $e');
      return false;
    }
  }
}