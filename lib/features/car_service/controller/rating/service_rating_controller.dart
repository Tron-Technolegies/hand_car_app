import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_rating_controller.g.dart';


@riverpod
class ServiceRatingController extends _$ServiceRatingController {
  @override
  FutureOr<void> build() {
    // Initial state
  }

  Future<ServiceRatingResponse> submitRating({
    required String serviceId,
    required int rating,
    String? comment,
  }) async {
    state = const AsyncLoading();

    try {
    
      final response = await ReviewService().addServiceRating(
        ServiceRatingModel(
          serviceId: serviceId,
          rating: rating,
          comment: comment,
        ),
      );

      if (response.error != null) {
        state = AsyncError(response.error!, StackTrace.current);
      } else {
        state = const AsyncData(null);
      }

      return response;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return const ServiceRatingResponse(error: 'Failed to submit rating');
    }
  }
}