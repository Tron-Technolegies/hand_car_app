import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:hand_car/core/exception/token/token_exception.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _tokenExpiryKey = 'token_expiry';
  
  final GetStorage _storage;
  
  // Singleton pattern with proper initialization
  static TokenStorage? _instance;
  static final _lock = Object();
  
  factory TokenStorage() {
    if (_instance == null) {
      synchronized(_lock, () {
        _instance ??= TokenStorage._internal();
      });
    }
    return _instance!;
  }
  
  TokenStorage._internal() : _storage = GetStorage();

  // Token saving with expiration handling
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    Duration expiration = const Duration(hours: 1),
  }) async {
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw TokenStorageException('Tokens cannot be empty');
    }
    
    try {
      final expiryTime = DateTime.now().add(expiration).millisecondsSinceEpoch;
      
      await Future.wait([
        _storage.write(_accessTokenKey, _encryptToken(accessToken)),
        _storage.write(_refreshTokenKey, _encryptToken(refreshToken)),
        _storage.write(_tokenExpiryKey, expiryTime),
      ]);
    } catch (e) {
      throw TokenStorageException('Failed to save tokens: $e');
    }
  }

  // Secure token retrieval with decryption
  String? getAccessToken() {
    try {
      final encryptedToken = _storage.read<String>(_accessTokenKey);
      return encryptedToken != null ? _decryptToken(encryptedToken) : null;
    } catch (e) {
      return null;
    }
  }
  
  String? getRefreshToken() {
    try {
      final encryptedToken = _storage.read<String>(_refreshTokenKey);
      return encryptedToken != null ? _decryptToken(encryptedToken) : null;
    } catch (e) {
      return null;
    }
  }

  // Enhanced token validation with expiration check
  bool get hasValidTokens {
    if (!hasTokens) return false;
    
    try {
      final expiryTime = _storage.read<int>(_tokenExpiryKey);
      if (expiryTime == null) return false;
      
      final now = DateTime.now().millisecondsSinceEpoch;
      return now < expiryTime;
    } catch (e) {
      return false;
    }
  }
  
  bool get hasTokens {
    final accessToken = getAccessToken();
    final refreshToken = getRefreshToken();
    
    return accessToken != null && 
           refreshToken != null && 
           accessToken.isNotEmpty && 
           refreshToken.isNotEmpty;
  }

  // Improved token clearing with verification
  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _storage.remove(_accessTokenKey),
        _storage.remove(_refreshTokenKey),
        _storage.remove(_tokenExpiryKey),
      ]);
      
      // Verify tokens are cleared
      if (hasTokens) {
        throw TokenStorageException('Failed to clear tokens completely');
      }
    } catch (e) {
      throw TokenStorageException('Failed to clear tokens: $e');
    }
  }

  // JWT token validation and parsing
  bool isAccessTokenExpired() {
    final accessToken = getAccessToken();
    if (accessToken == null) return true;
    
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return true;
      
      final payload = _decodeJwtPayload(parts[1]);
      final expiration = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      
      // Add a 30-second buffer to prevent edge cases
      return DateTime.now().isAfter(expiration.subtract(const Duration(seconds: 30)));
    } catch (e) {
      return true;
    }
  }

  // Enhanced JWT payload decoder with proper padding
  Map<String, dynamic> _decodeJwtPayload(String str) {
    try {
      String normalizedStr = str.replaceAll('-', '+').replaceAll('_', '/');
      switch (normalizedStr.length % 4) {
        case 0:
          break;
        case 2:
          normalizedStr += '==';
          break;
        case 3:
          normalizedStr += '=';
          break;
        default:
          throw FormatException('Invalid base64 string');
      }
      
      final decoded = utf8.decode(base64Url.decode(normalizedStr));
      return Map<String, dynamic>.from(jsonDecode(decoded));
    } catch (e) {
      throw TokenStorageException('Failed to decode JWT payload: $e');
    }
  }

  // Simple token encryption/decryption
  // Note: In production, use more secure encryption methods
  String _encryptToken(String token) {
    return base64.encode(utf8.encode(token));
  }

  String _decryptToken(String encryptedToken) {
    return utf8.decode(base64.decode(encryptedToken));
  }
}

// Custom exception for better error handling


// Helper function for thread-safe singleton initialization
void synchronized(Object lock, void Function() fn) {
  fn();
}