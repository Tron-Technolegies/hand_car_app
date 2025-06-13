// features/Accessories/model/review/review_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    int? id,
    required int rating,
    String? comment,
    @JsonKey(fromJson: _userFromJson) String? user,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

  Map<String, dynamic> toJson() => {
        'id': id,
        'rating': rating,
        'comment': comment,
        'user': user,
      };
}

String? _userFromJson(dynamic value) => value?.toString();