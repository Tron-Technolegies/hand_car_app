// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefreshTokenResponseImpl _$$RefreshTokenResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$RefreshTokenResponseImpl(
      message: json['message'] as String,
      accessToken: json['access_token'] as String,
    );

Map<String, dynamic> _$$RefreshTokenResponseImplToJson(
        _$RefreshTokenResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'access_token': instance.accessToken,
    };
