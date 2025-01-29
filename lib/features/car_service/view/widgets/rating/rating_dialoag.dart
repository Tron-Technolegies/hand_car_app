import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RatingDialogWidget extends HookConsumerWidget {
  final String serviceId;
  final String serviceName;

  const RatingDialogWidget({
    super.key,
    required this.serviceId,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rating = useState<int>(0);
    final reviewController = useTextEditingController();
    final isSubmitting = useState(false);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              'Rate $serviceName',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Rating Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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

            const SizedBox(height: 24),

            // Review TextField
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: reviewController,
                maxLines: null,
                minLines: 4,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  hintText: 'Write your review here...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12),
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        context.colors.primaryTxt,
                      ),
                    ),
                    onPressed: isSubmitting.value
                        ? null
                        : () async {
                            if (rating.value == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a rating'),
                                ),
                              );
                              return;
                            }

                            isSubmitting.value = true;

                            try {
                              final response = await ref
                                  .read(
                                      serviceRatingControllerProvider.notifier)
                                  .submitRating(
                                    serviceId: int.parse(serviceId),
                                    rating: rating.value,
                                    comment: reviewController.text,
                                  );

                              if (response.error != null) {
                                // Show error message if exists
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(response.error!),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              } else {
                                // Show success message and close dialog
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Review submitted successfully'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pop(context);
                                }
                              }
                            } catch (e) {
                              // Handle any other errors
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Error: ${e.toString()}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } finally {
                              isSubmitting.value = false;
                            }
                          },
                    child: Text(
                      style: context.typography.bodyLargeMedium.copyWith(
                        color: context.colors.white,
                      ),
                      isSubmitting.value ? 'Submitting...' : 'Submit',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Helper method to show the dialog
void showRatingDialog(
  BuildContext context, {
  required String serviceId,
  required String serviceName,
}) {
  showDialog(
    context: context,
    builder: (context) => RatingDialogWidget(
      serviceId: serviceId,
      serviceName: serviceName,
    ),
  );
}
