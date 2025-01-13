import 'package:flutter/material.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rating_dialog/rating_dialog.dart' as rating_dialog;
import 'package:hand_car/core/extension/theme_extension.dart';

class ServiceRatingDialog extends ConsumerWidget {
  final String serviceId;
  final String serviceName;
  final String? serviceImage;

  const ServiceRatingDialog({
    super.key,
    required this.serviceId,
    required this.serviceName,
    this.serviceImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller=TextEditingController();
    final dialog = rating_dialog.RatingDialog(
      initialRating: 1.0,
      title: Text(
        'Rate $serviceName',
        textAlign: TextAlign.center,
        style: context.typography.h3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      message: Text(
        'How was your experience with this service?',
        textAlign: TextAlign.center,
        style: context.typography.bodyMedium,
      ),
      image: Container(
        constraints: const BoxConstraints(
          maxWidth: 200,
          maxHeight: 200,
        ),
        alignment: Alignment.center,
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          image: serviceImage != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(serviceImage!),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: serviceImage == null
            ? Icon(
                Icons.car_repair,
                size: 80,
                color: context.colors.primary,
              )
            : null,
      ),
      submitButtonText: 'Submit Review',
      submitButtonTextStyle: context.typography.bodyMedium.copyWith(
        color: Colors.black,
      ),
      commentHint: 'Tell us about your experience (optional)',
      
      starSize: 32,
      starColor: Colors.amber,
      onCancelled: () => Navigator.pop(context),
      onSubmitted: (response) async {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        try {
          final result = await ref
              .read(serviceRatingControllerProvider.notifier)
              .submitRating(
                serviceId: int.parse(serviceId),
                rating: response.rating.toInt(),
                comment: response.comment.isNotEmpty ? response.comment : null,
              );

          if (context.mounted) {
            Navigator.pop(context); // Dismiss loading indicator
            Navigator.pop(context); // Dismiss rating dialog

            if (result.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(result.error!),
                  backgroundColor: context.colors.warning,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Thank you for your review!'),
                  backgroundColor: context.colors.green,
                ),
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            Navigator.pop(context); // Dismiss loading indicator
            Navigator.pop(context); // Dismiss rating dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    const Text('Failed to submit review. Please try again.'),
                backgroundColor: context.colors.warning,
              ),
            );
          }
        }
      },
    );

    return dialog;
  }
}

// Helper method to show the dialog
void showServiceRatingDialog({
  required BuildContext context,
  required String serviceId,
  required String serviceName,
  String? serviceImage,
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => ServiceRatingDialog(
      serviceId: serviceId,
      serviceName: serviceName,
      serviceImage: serviceImage,
    ),
  );
}
