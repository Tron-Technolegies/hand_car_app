import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const AuthModel._();  // Added for custom methods

  const factory AuthModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    required String message,
    @Default(false) bool isLoading,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
      
  bool get isAuthenticated =>
      accessToken.isNotEmpty && 
      refreshToken.isNotEmpty && 
      !isLoading;
      
  // Added helper method for token validation
  bool get isTokenValid {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return false;
      
      // Add padding to base64url string
      String normalized = base64Url.normalize(parts[1]);
      
      // Decode the JWT payload
      final payloadString = utf8.decode(base64Url.decode(normalized));
      final payload = jsonDecode(payloadString) as Map<String, dynamic>;
      
      final expiration = DateTime.fromMillisecondsSinceEpoch(
        (payload['exp'] as int) * 1000
      );
      
      return DateTime.now().isBefore(expiration);
    } catch (_) {
      return false;
    }
  }
}