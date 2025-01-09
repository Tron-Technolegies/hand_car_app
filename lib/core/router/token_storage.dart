// import 'package:get_storage/get_storage.dart';

import 'dart:convert';

import 'package:get_storage/get_storage.dart';

class TokenStorage {
  final _storage = GetStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await Future.wait([
      _storage.write(_accessTokenKey, accessToken),
      _storage.write(_refreshTokenKey, refreshToken),
    ]);
  }

  String? getAccessToken() => _storage.read<String>(_accessTokenKey);
  String? getRefreshToken() => _storage.read<String>(_refreshTokenKey);

  Future<void> clearTokens() async {
    await Future.wait([
      _storage.remove(_accessTokenKey),
      _storage.remove(_refreshTokenKey),
    ]);
  }

  bool get hasTokens {
    final accessToken = getAccessToken();
    final refreshToken = getRefreshToken();
    return accessToken != null && refreshToken != null &&
           accessToken.isNotEmpty && refreshToken.isNotEmpty;
  }
}


class TokenStorageException implements Exception {
  final String message;
  TokenStorageException(this.message);
  
  @override
  String toString() => 'TokenStorageException: $message';
}