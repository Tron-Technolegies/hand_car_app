import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:hand_car/core/exception/token/token_exception.dart';
import 'package:synchronized/synchronized.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _accessExpiryKey = 'access_token_expiry';
  static const String _refreshExpiryKey = 'refresh_token_expiry';
  static const int _refreshThresholdMinutes = 5;

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

  Future<void> saveRefreshedAccessToken(String accessToken) async {
  try {
    if (accessToken.isEmpty) {
      throw TokenStorageException('Access token cannot be empty');
    }

    // Decode and validate new access token
    final accessPayload = decodeJwtPayload(accessToken.split('.')[1]);
    final accessExpiry = accessPayload['exp'] * 1000;
    final userId = accessPayload['user_id'];

    log('Saving refreshed access token:'
        '\nNew Access Token Expiry: ${DateTime.fromMillisecondsSinceEpoch(accessExpiry)}'
        '\nUser ID: $userId');

    // Save only the new access token and its expiry
    await _lock.synchronized(() async {
      await Future.wait([
        _storage.write(_accessTokenKey, _encryptToken(accessToken)),
        _storage.write(_accessExpiryKey, accessExpiry),
      ]);
    });

    // Verify the saved access token
    final savedToken = getAccessToken();
    if (savedToken == null) {
      throw TokenStorageException('Failed to retrieve saved access token');
    }

    // Additional verification of token payload
    final savedPayload = decodeJwtPayload(savedToken.split('.')[1]);
    if (savedPayload['user_id'] != userId) {
      throw TokenStorageException('Token user ID mismatch');
    }

    log('Refreshed access token saved and verified successfully');
  } catch (e) {
    log('Error saving refreshed access token: $e');
    throw TokenStorageException('Failed to save refreshed access token: $e');
  }
}

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      if (accessToken.isEmpty || refreshToken.isEmpty) {
        throw TokenStorageException('Tokens cannot be empty');
      }

      // Decode and validate both tokens
      final accessPayload = decodeJwtPayload(accessToken.split('.')[1]);
      final refreshPayload = decodeJwtPayload(refreshToken.split('.')[1]);

      // Extract expiration times
      final accessExpiry = accessPayload['exp'] * 1000;
      final refreshExpiry = refreshPayload['exp'] * 1000;

      log('Saving tokens:'
          '\nAccess Token Expiry: ${DateTime.fromMillisecondsSinceEpoch(accessExpiry)}'
          '\nRefresh Token Expiry: ${DateTime.fromMillisecondsSinceEpoch(refreshExpiry)}');

      await _lock.synchronized(() async {
        await Future.wait([
          _storage.write(_accessTokenKey, _encryptToken(accessToken)),
          _storage.write(_refreshTokenKey, _encryptToken(refreshToken)),
          _storage.write(_accessExpiryKey, accessExpiry),
          _storage.write(_refreshExpiryKey, refreshExpiry),
        ]);
      });

      log('Tokens saved and verified successfully');
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

      final decryptedToken = _decryptToken(encryptedToken);
      if (!isTokenValid(decryptedToken)) {
        log('Access token is invalid or expired');
        return null;
      }

      return decryptedToken;
    } catch (e) {
      log('Error getting access token: $e');
      return null;
    }
  }

  String? getRefreshToken() {
    try {
      final encryptedToken = _storage.read<String>(_refreshTokenKey);
      if (encryptedToken == null) return null;

      final decryptedToken = _decryptToken(encryptedToken);
      if (!isTokenValid(decryptedToken)) {
        log('Refresh token is invalid or expired');
        return null;
      }

      return decryptedToken;
    } catch (e) {
      log('Error getting refresh token: $e');
      return null;
    }
  }

  bool isTokenValid(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return false;

      final payload = decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return DateTime.now().isBefore(expiration);
    } catch (e) {
      return false;
    }
  }

  bool isAccessTokenExpired() {
    try {
      final token = getAccessToken();
      if (token == null) return true;

      final parts = token.split('.');
      final payload = decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      final now = DateTime.now();

      // Consider token expired if less than threshold minutes remaining
      final timeUntilExpiry = expiration.difference(now);
      final isExpired = timeUntilExpiry.inMinutes <= _refreshThresholdMinutes;

      if (isExpired) {
        log('Access token will expire in ${timeUntilExpiry.inMinutes} minutes');
      }

      return isExpired;
    } catch (e) {
      log('Error checking access token expiration: $e');
      return true;
    }
  }

  bool isRefreshTokenExpired() {
    try {
      final token = getRefreshToken();
      if (token == null) return true;

      final parts = token.split('.');
      final payload = decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return DateTime.now().isAfter(expiration);
    } catch (e) {
      log('Error checking refresh token expiration: $e');
      return true;
    }
  }

  Duration? getAccessTokenRemainingTime() {
    try {
      final token = getAccessToken();
      if (token == null) return null;

      final parts = token.split('.');
      final payload = decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      return expiration.difference(DateTime.now());
    } catch (e) {
      log('Error calculating remaining time: $e');
      return null;
    }
  }

  Map<String, dynamic> decodeJwtPayload(String str) {
    try {
      String normalized = str.replaceAll('-', '+').replaceAll('_', '/');
      switch (normalized.length % 4) {
        case 0:
          break;
        case 2:
          normalized += '==';
          break;
        case 3:
          normalized += '=';
          break;
        default:
          throw FormatException('Invalid base64 string');
      }
      final decoded = utf8.decode(base64Url.decode(normalized));
      return Map<String, dynamic>.from(jsonDecode(decoded));
    } catch (e) {
      log('Error decoding JWT payload: $e');
      throw TokenStorageException('Invalid JWT payload');
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
          _storage.remove(_accessExpiryKey),
          _storage.remove(_refreshExpiryKey),
        ]);
      });
      log('Tokens cleared successfully');
    } catch (e) {
      log('Error clearing tokens: $e');
      throw TokenStorageException('Failed to clear tokens: $e');
    }
  }

  bool get hasValidTokens {
    try {
      final accessToken = getAccessToken();
      final refreshToken = getRefreshToken();

      return accessToken != null &&
          refreshToken != null &&
          !isAccessTokenExpired() &&
          !isRefreshTokenExpired();
    } catch (e) {
      log('Error checking token validity: $e');
      return false;
    }
  }
}
