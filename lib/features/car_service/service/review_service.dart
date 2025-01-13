import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';

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
        '/add_service_rating',
        data: FormData.fromMap( {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment != null) 'comment': rating.comment,
        },
      ));

      return ServiceRatingResponse.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response != null) {
        return ServiceRatingResponse.fromJson(e.response!.data);
      }
      return const ServiceRatingResponse(error: 'Failed to submit rating');
    }
  }
}