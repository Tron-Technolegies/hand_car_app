import 'package:flutter/material.dart';
import 'package:hand_car/core/controller/multiple_image_picker_provider.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/review_items_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ReviewListWidget For Show In Details Page
class ReviewsList extends ConsumerWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(multipleImagePickerProvider);

    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => ReviewItemsWidget(
        username: "Risan",
        date: "10/10/2022",
        comment: "Nice perfume in affordable price",
        review:
            "I found Davidoff Cool Water perfume is a timeless and refreshing fragrance that exudes elegance and sophistication. The captivating blend of aromatic and aquatic notes creates a sense of tranquility and vitality, perfect for both casual and formal occasions.",
        rating: 5,
        images: images.selectedImages.map((xFile) => xFile.path).toList(),
      ),
    );
  }
}
