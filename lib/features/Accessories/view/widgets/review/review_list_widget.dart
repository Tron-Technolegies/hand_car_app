
// features/Accessories/view/widgets/review/review_list_widget.dart
import 'package:flutter/material.dart';
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
    if (reviews.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('No reviews yet. Be the first to write one!'),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ReviewItemsWidget(
          username: review.user ?? 'Anonymous',
          comment: review.comment ?? '',
          rating: review.rating,
        );
      },
    );
  }
}
