import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/review/review_model.dart';

class ReviewApiServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  // Initialize secure storage
  static final _storage = GetStorage();

  // Add interceptor to include JWT token
  ReviewApiServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Retrieve token from get storage
          String? token = _storage.read( 'jwt_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }
  Future<List<ReviewModel>> getReviews({required int productId}) async {
  try {
    final response = await _dio.get('/view_review/$productId/');

    if (response.statusCode == 200) {
      // Check if reviews exist
      if (response.data['reviews'] != null) {
        List<dynamic> reviewsJson = response.data['reviews'];
        return reviewsJson
            .map((json) => ReviewModel(
                  id: json['id'],
                  rating: json['rating'],
                  comment: json['comment'],
                ))
            .toList();
      } else {
        return []; 
      }
    }

    throw Exception('Failed to fetch reviews');
  } on DioException catch (e) {
    if (e.response?.statusCode == 400) {
      throw Exception(e.response?.data['error'] ?? 'Failed to fetch reviews');
    } else if (e.response?.statusCode == 401) {
      throw Exception('Unauthorized: Invalid or missing token');
    }
    throw Exception('Failed to fetch reviews: ${e.message}');
  }
}

  Future<ReviewModel> addReview({
    required int productId,
    required int rating,
    required String comment,
  }) async {
    try {
      final response = await _dio.post(
        '/add_review/$productId/',
        data: {
          'rating': rating,
          'comment': comment,
        },
      );

      if (response.statusCode == 201) {
        return ReviewModel(
          id: response.data['review_id'],
          rating: rating,
          comment: comment,
        );
      }

      throw Exception('Failed to add review');
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception(e.response?.data['error'] ?? 'Failed to add review');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized: Invalid or missing token');
      }
      throw Exception('Failed to add review: ${e.message}');
    }
  }
}