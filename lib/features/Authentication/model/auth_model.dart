import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String accessToken,
    required String refreshToken,
    required String message,
  }) = _AuthModel;

  /// JSON serialization
  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);
}

/// Extension to add custom getters or methods to AuthModel
extension AuthModelX on AuthModel {
  bool get isAuthenticated =>
      accessToken.isNotEmpty && refreshToken.isNotEmpty;
}