import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'package:hand_car/features/car_service/service/review_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_rating_controller.g.dart';


@riverpod
class ServiceRatingController extends _$ServiceRatingController {
  @override
  FutureOr<ServiceRatingList> build() {
    return _fetchRatings();
  }
  Future<ServiceRatingList> _fetchRatings() async {
    final repository = ReviewService().getServiceRatings();
    return repository;
  }

  Future<void> refreshRatings() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetchRatings);
  }
   Future<ServiceRatingResponse> submitRating({
    required int serviceId,
    required int rating,
    String? comment,
  }) async {
    try {
      final response = await ReviewService().addServiceRating(
        ServiceRatingModel(
          serviceId: serviceId,
          rating: rating,
          comment: comment,
        ),
      );

      if (response.error == null) {
        await refreshRatings();
      }

      return response;
    } catch (error) {
      return ServiceRatingResponse(error: error.toString());
    }
  }
}