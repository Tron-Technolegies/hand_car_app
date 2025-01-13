import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';

class ReviewService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

   Future<ServiceRatingResponse> addServiceRating(ServiceRatingModel rating) async {
    try {
      final response = await _dio.post(
        '/api/add_service_rating/',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment != null) 'comment': rating.comment,
        },
      );

      return ServiceRatingResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return ServiceRatingResponse.fromJson(e.response!.data);
      }
      return const ServiceRatingResponse(error: 'Failed to submit rating');
    }
  }
}