import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';

part 'total_rating.g.dart';



@riverpod
AsyncValue<double> serviceRatingAsync( ref, int serviceId) {
  final ratingsAsync = ref.watch(serviceRatingControllerProvider);
  
  if (ratingsAsync is AsyncLoading) {
    return const AsyncLoading();
  }
  
  if (ratingsAsync is AsyncError) {
    return AsyncError(ratingsAsync.error, ratingsAsync.stackTrace);
  }
  
  final ratingList = ratingsAsync.value;
  if (ratingList == null) return const AsyncData(0.0);
  
  final serviceRatings = ratingList.ratings
      .where((rating) => rating.vendorName == serviceId.toString())
      .toList();
      
  if (serviceRatings.isEmpty) return const AsyncData(0.0);
  
  final totalRating = serviceRatings.fold<double>(
    0.0,
    (sum, rating) => sum + rating.rating,
  );
  
  return AsyncData(totalRating / serviceRatings.length);
}