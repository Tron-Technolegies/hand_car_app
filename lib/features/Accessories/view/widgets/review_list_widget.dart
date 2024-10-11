import 'package:flutter/material.dart';
import 'package:hand_car/core/controller/multiple_image_picker_provider.dart';
import 'package:hand_car/features/Accessories/view/widgets/review_items_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReviewsList extends ConsumerWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(multipleImagePickerProvider).selectedImages;
    int itemCount = images.length;  // Ensure itemCount matches the list length

    return ListView.builder(
      itemCount: itemCount,  // Use the dynamic itemCount
      itemBuilder: (context, index) {
        // Check if index is within the list range before accessing
        if (index < itemCount) {
          return ReviewItemsWidget(
            username: "Risan",
            date: "10/10/2022",
            comment: "Nice perfume at an affordable price",
            review: "I found Davidoff Cool Water perfume is a timeless and refreshing fragrance...",
            rating: 5,
             // Safely access the image path
          );
        } else {
          // Return an empty widget if index is out of range
          return SizedBox.shrink();
        }
      },
    );
  }
}