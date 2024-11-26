// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticationStateImpl _$$AuthenticationStateImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticationStateImpl(
      isLoading: json['isLoading'] as bool,
      authenticated: json['authenticated'] as bool,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$$AuthenticationStateImplToJson(
        _$AuthenticationStateImpl instance) =>
    <String, dynamic>{
      'isLoading': instance.isLoading,
      'authenticated': instance.authenticated,
      'errorMessage': instance.errorMessage,
    };
