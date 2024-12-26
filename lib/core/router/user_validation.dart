// import 'package:get_storage/get_storage.dart';

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  
  final GetStorage _storage;
  
  // Singleton pattern for consistent storage instance
  static final TokenStorage _instance = TokenStorage._internal();
  
  factory TokenStorage() {
    return _instance;
  }
  
  TokenStorage._internal() : _storage = GetStorage();
  
  // Improved token saving with validation
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    if (accessToken.isEmpty || refreshToken.isEmpty) {
      throw TokenStorageException('Tokens cannot be empty');
    }
    
    try {
      await Future.wait([
        _storage.write(_accessTokenKey, accessToken),
        _storage.write(_refreshTokenKey, refreshToken),
      ]);
    } catch (e) {
      throw TokenStorageException('Failed to save tokens: $e');
    }
  }
  
  // Enhanced token clearing with error handling
  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _storage.remove(_accessTokenKey),
        _storage.remove(_refreshTokenKey),
      ]);
    } catch (e) {
      throw TokenStorageException('Failed to clear tokens: $e');
    }
  }
  
  // Nullable getters with type safety
  String? getAccessToken() {
    try {
      return _storage.read<String>(_accessTokenKey);
    } catch (e) {
      return null;
    }
  }
  
  String? getRefreshToken() {
    try {
      return _storage.read<String>(_refreshTokenKey);
    } catch (e) {
      return null;
    }
  }
  
  // Enhanced token validation
  bool get hasTokens {
    final accessToken = getAccessToken();
    final refreshToken = getRefreshToken();
    
    return accessToken != null && 
           refreshToken != null && 
           accessToken.isNotEmpty && 
           refreshToken.isNotEmpty;
  }
  
  // Added method to check token expiration
  bool isAccessTokenExpired() {
    final accessToken = getAccessToken();
    if (accessToken == null) return true;
    
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return true;
      
      final payload = _decodeBase64(parts[1]);
      final expiration = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      
      return DateTime.now().isAfter(expiration);
    } catch (e) {
      return true;
    }
  }
  
  // Helper method to decode JWT payload
  Map<String, dynamic> _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw TokenStorageException('Invalid base64 string');
    }
    return Map<String, dynamic>.from(
      jsonDecode(
        utf8.decode(
          base64Url.decode(output),
        ),
      ),
    );
  }
}

class TokenStorageException implements Exception {
  final String message;
  TokenStorageException(this.message);
  
  @override
  String toString() => 'TokenStorageException: $message';
}