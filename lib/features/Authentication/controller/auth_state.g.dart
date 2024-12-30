// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationStateImpl _$$AuthenticationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationStateImpl(
      isLoading: json['is_loading'] as bool,
      authenticated: json['authenticated'] as bool,
      errorMessage: json['error_message'] as String?,
    );

Map<String, dynamic> _$$AuthenticationStateImplToJson(
        _$AuthenticationStateImpl instance) =>
    <String, dynamic>{
      'is_loading': instance.isLoading,
      'authenticated': instance.authenticated,
      if (instance.errorMessage case final value?) 'error_message': value,
    };
