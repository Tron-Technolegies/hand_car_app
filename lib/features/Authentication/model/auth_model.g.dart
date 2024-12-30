// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthModelImpl _$$AuthModelImplFromJson(Map<String, dynamic> json) =>
    _$AuthModelImpl(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      message: json['message'] as String,
      isLoading: json['is_loading'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthModelImplToJson(_$AuthModelImpl instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'message': instance.message,
      'is_loading': instance.isLoading,
    };
