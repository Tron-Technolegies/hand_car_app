import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/review_items_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ReviewListWidget For Show In Details Page
class ReviewsList extends ConsumerWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ReviewItemsWidget(
        username: "Risan",
        
        comment: "Nice perfume in affordable price",

        rating: 5,
     
      ),
    );
  }
}
