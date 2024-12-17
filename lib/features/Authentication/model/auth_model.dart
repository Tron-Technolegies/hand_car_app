import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    @JsonKey(name: 'access_token') required String accessToken,
    @JsonKey(name: 'refresh_token') required String refreshToken,
    required String message,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, dynamic> json) => 
      _$AuthModelFromJson(json);
}

extension AuthModelX on AuthModel {
  bool get isAuthenticated => 
      accessToken.isNotEmpty && refreshToken.isNotEmpty;
}
