
import 'package:dio/dio.dart';
import 'package:hand_car/core/service/base_api_service.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';

class ReviewService extends BaseApiService {
 ReviewService() : super();

 Future<ServiceRatingResponse> addServiceRating(ServiceRatingModel rating) async {
    return withRetry(() async {
      final token = tokenStorage.getAccessToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await dio.post(
        '/add_service_rating',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
        options: Options(
          headers: {
            'Cookie': 'access_token=$token', // Ensure cookie is set
          },
          // Enable credentials
          extra: {
            'withCredentials': true,
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }
      throw handleApiError(response);
    });
  }

 Future<ServiceRatingList> getServiceRatings(int serviceId) async {

     final response = await dio.get(
       '/view_service_rating',
       queryParameters: {'service_id': serviceId.toString()},
     );

     if (response.statusCode == 404) {
       return const ServiceRatingList(ratings: []);
     }

     if (response.statusCode == 200) {
       return ServiceRatingList.fromJson(response.data);
     }

     throw handleApiError(response);
   
 }
}
