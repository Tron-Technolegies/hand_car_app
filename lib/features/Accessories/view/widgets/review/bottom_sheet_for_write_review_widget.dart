
// features/Accessories/view/widgets/review/bottom_sheet_for_write_accessory_review_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/services.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/review/review_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';

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
    final rating = useState<int>(0); // Changed to int with 0 default
    final commentController = useTextEditingController();
    final isSubmitting = useState(false);

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: context.space.space_200),
          // Title with drag handle
          Center(
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Text(
                  'Rate $productName',
                  style: context.typography.h3.copyWith(
                    color: context.colors.primaryTxt,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: context.space.space_300),
          // Rating Bar
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                final starValue = index + 1;
                return GestureDetector(
                  onTap: isSubmitting.value ? null : () => rating.value = starValue,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      starValue <= rating.value ? Icons.star : Icons.star_border,
                      size: 36,
                      color: Colors.amber,
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: context.space.space_200),
          // Comment Text Field
          Container(
            margin: EdgeInsets.symmetric(horizontal: context.space.space_200),
            decoration: BoxDecoration(
              color: context.colors.background,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: context.colors.containerShadow,
                width: 1,
              ),
            ),
            child: TextField(
              controller: commentController,
              maxLines: null,
              minLines: 5,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              style: context.typography.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Write your review here..',
                hintStyle: context.typography.bodyMedium.copyWith(
                  color: context.colors.secondaryTxt,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(context.space.space_200),
              ),
              enabled: !isSubmitting.value,
            ),
          ),
          SizedBox(height: context.space.space_300),
          // Submit Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
            child: SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                label: isSubmitting.value ? 'Submitting...' : 'Submit Review',
                onTap: isSubmitting.value
                    ? null
                    : () async {
                        if (rating.value == 0) {
                          SnackbarUtil.showsnackbar(message: 'Please select a rating');
                          return;
                        }

                        isSubmitting.value = true;
                        log('BottomSheet: Initiating review submission for product ID: $productId');

                        try {
                          // Simulate 2-second delay
                          await Future.delayed(const Duration(seconds: 2));

                          final response = await ref.read(reviewControllerProvider.notifier).submitReview(
                                productId: int.parse(productId),
                                rating: rating.value,
                                comment: commentController.text,
                              );

                          if (response.error == null) {
                            log('BottomSheet: Review submitted successfully');
                            SnackbarUtil.showsnackbar(message: 'Review submitted successfully!');
                            if (context.mounted) {
                              Navigator.pop(context); // Close bottom sheet
                            }
                          } else {
                            log('BottomSheet: Review submission failed: ${response.error}');
                            SnackbarUtil.showsnackbar(
                              message: response.error!,
                             
                            );
                          }
                        } catch (e) {
                          log('BottomSheet: Error submitting review: $e');
                          SnackbarUtil.showsnackbar(
                            message: 'Failed to submit review. Please try again.',
                           
                          );
                        } finally {
                          isSubmitting.value = false;
                        }
                      },
              ),
            ),
          ),
          SizedBox(height: context.space.space_200),
        ],
      ),
    );
  }
}
