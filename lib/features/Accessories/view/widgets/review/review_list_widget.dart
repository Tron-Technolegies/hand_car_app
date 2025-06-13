
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/review_items_widget.dart';

class ReviewListWidget extends StatelessWidget {
  final List<ReviewModel> reviews;

  const ReviewListWidget({
    super.key,
    required this.reviews,
  });

  @override
  Widget build(BuildContext context) {
    final validReviews = reviews.where((review) => review.rating != null).toList();

    if (validReviews.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Text(
          'No reviews yet. Be the first to write one!',
          style: context.typography.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: validReviews.length,
      itemBuilder: (context, index) {
        final review = validReviews[index];
        return ReviewItemsWidget(
          username: review.user ?? 'Anonymous',
          comment: review.comment ?? '',
          rating: review.rating!, 
        );
      },
    );
  }
}
