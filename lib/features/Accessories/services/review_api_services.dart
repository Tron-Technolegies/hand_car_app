import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/controller/model/review/review_model.dart';

class ReviewApiServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },  
    ),

  );
  Future<ReviewModel> addReview(int productId, int rating, String comment) async {
    try {
      final response = await _dio.post(
        '/add_review/',
        data: {
          'product_id': productId,
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
      }
      throw Exception('Failed to add review: ${e.message}');
    }
  }
}