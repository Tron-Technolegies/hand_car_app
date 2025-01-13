import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/review/review_controller.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class BottomSheetForWriteReviewWidget extends HookConsumerWidget {
  final String serviceId;
  final String serviceName;

  const BottomSheetForWriteReviewWidget({
    super.key,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = useState<int>(0);
    final reviewController = useTextEditingController();
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
          
          // Title
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
                  'Rate $serviceName',
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
                return GestureDetector(
                  onTap: () => rating.value = index + 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      index < rating.value ? Icons.star : Icons.star_border,
                      size: 36,
                      color: Colors.amber,
                    ),
                  ),
                );
              }),
            ),
          ),

          SizedBox(height: context.space.space_200),

          // Review Text Field
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
              controller: reviewController,
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
            ),
          ),

          SizedBox(height: context.space.space_300),

          // Submit Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
            child: SizedBox(
              width: double.infinity,
              child: ButtonWidget(
                label: isSubmitting.value ? "Submitting..." : "Submit Review",
                onTap: 
                 () async {
                        if (rating.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a rating'),
                            ),
                          );
                          return;
                        }

                        isSubmitting.value = true;

                        await ref
                            .read(serviceRatingControllerProvider.notifier)
                            .submitRating(serviceId: int.parse(serviceId), rating: rating.value, comment: reviewController.text);

                        isSubmitting.value = false;
                        if (context.mounted) {
                          Navigator.pop(context);
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