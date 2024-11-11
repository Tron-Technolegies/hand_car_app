import 'package:freezed_annotation/freezed_annotation.dart';
part 'auth_state.g.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  factory AuthenticationState(
      {required bool isLoading,
      required bool authenticated}) = _AuthenticationState;
  factory AuthenticationState.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationStateFromJson(json);
}
