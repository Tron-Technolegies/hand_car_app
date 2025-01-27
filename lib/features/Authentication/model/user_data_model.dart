import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  const factory UserDataModel({
    required int id,
    required String username,
    required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'profile_image') String? profileImage,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);

  const UserDataModel._();

  String get fullName => '$firstName $lastName';
}