
// features/Accessories/view/widgets/review/bottom_sheet_for_write_review_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/review/review_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomSheetForWriteAccessoryReviewWidget extends HookConsumerWidget {
  final String productId;
  final String productName;

  const BottomSheetForWriteAccessoryReviewWidget({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = useState(0);
    final commentController = useTextEditingController();
    final isSubmitting = useState(false);

    return Padding(
      padding: EdgeInsets.all(context.space.space_200)
          .copyWith(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Write a Review for $productName',
            style: context.typography.h3,
          ),
          SizedBox(height: context.space.space_200),
          Text(
            'Rating',
            style: context.typography.bodyLargeMedium,
          ),
          Row(
            children: List.generate(
              5,
              (index) => IconButton(
                icon: Icon(
                  index < rating.value ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
                onPressed: () => rating.value = index + 1,
              ),
            ),
          ),
          SizedBox(height: context.space.space_200),
          TextField(
            controller: commentController,
            decoration: InputDecoration(
              labelText: 'Comment',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.space.space_100),
              ),
            ),
            maxLines: 4,
          ),
          SizedBox(height: context.space.space_200),
          ButtonWidget(
            label: isSubmitting.value ? 'Submitting...' : 'Submit Review',
            onTap: isSubmitting.value
                ? null
                : () async {
                    if (rating.value == 0) {
                      SnackbarUtil.showsnackbar(message: 'Please select a rating');
                      return;
                    }
                    isSubmitting.value = true;
                    final response = await ref.read(reviewControllerProvider.notifier).submitReview(
                          productId: int.parse(productId),
                          rating: rating.value,
                          comment: commentController.text,
                        );
                    isSubmitting.value = false;
                    if (response.error != null) {
                      SnackbarUtil.showsnackbar(message: response.error!);
                    } else {
                      SnackbarUtil.showsnackbar(message: 'Review submitted successfully');
                      Navigator.pop(context);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
