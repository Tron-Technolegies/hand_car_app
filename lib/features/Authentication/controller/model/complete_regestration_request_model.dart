// Model for completing user registration with name and email
import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_regestration_request_model.freezed.dart';
part 'complete_regestration_request_model.g.dart';

@freezed
class CompleteRegistrationRequestModel with _$CompleteRegistrationRequestModel {
  const factory CompleteRegistrationRequestModel({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) = _CompleteRegistrationRequestModel;

  factory CompleteRegistrationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegistrationRequestModelFromJson(json);
}

