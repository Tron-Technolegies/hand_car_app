// refresh_token_response.dart

import 'package:freezed_annotation/freezed_annotation.dart';


part 'refresh_token_response.g.dart';
part 'refresh_token_response.freezed.dart';

@freezed
class RefreshTokenResponse with _$RefreshTokenResponse {
  const factory RefreshTokenResponse({
    required String message,
    @JsonKey(name: 'access_token') required String accessToken,
  }) = _RefreshTokenResponse;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenResponseFromJson(json);
}