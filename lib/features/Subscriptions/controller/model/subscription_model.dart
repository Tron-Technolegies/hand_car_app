
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const factory SubscriptionModel({
    required String plan,
    required String category,
    required String duration,
    required String whatsappUrl,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);
}

