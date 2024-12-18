import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

//Review Model class to get the data from the API
@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    int? id,
    required int rating,
    String? comment,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);
}