// review_service.dart
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/refresh_token.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:hand_car/features/car_service/model/rating/response/rating_response.dart';
import 'package:hand_car/features/car_service/model/rating/review_list/review_list_model.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';
import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'review_service.g.dart';

class ReviewService {
  final ApiServiceAuthentication _authService;
  late final Dio _dio;
  final TokenStorage _tokenStorage;  // Changed to final

  ReviewService({ApiServiceAuthentication? authService}) 
      : _authService = authService ?? ApiServiceAuthentication(),
        _tokenStorage = TokenStorage() {  // Initialize in constructor
    
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        validateStatus: (status) => status! < 500,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add the TokenInterceptor
    _dio.interceptors.add(TokenInterceptor(_dio, _tokenStorage));

    // Add logging interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('Request [${options.method}] ${options.path}');
          log('Headers: ${options.headers}');
          log('Data: ${options.data}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          log('Response [${response.statusCode}] ${response.requestOptions.path}');
          log('Data: ${response.data}');
          return handler.next(response);
        },
        onError: (error, handler) {
          log('Error [${error.response?.statusCode}] ${error.requestOptions.path}');
          log('Error Data: ${error.response?.data}');
          return handler.next(error);
        },
      ),
    );
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      switch (statusCode) {
        case 400:
          return data?['message'] ?? 'Invalid request';
        case 401:
          return 'Please login to continue';
        case 403:
          return 'Access denied';
        case 404:
          return 'Service not found';
        case 422:
          return 'Invalid rating data';
        case 429:
          return 'Too many attempts. Please try again later';
        case 500:
          return 'Server error. Please try again later';
        default:
          return data?['message'] ?? 'An unknown error occurred';
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timeout. Please check your internet';
      case DioExceptionType.receiveTimeout:
        return 'Server not responding. Please try again later';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error. Please check your connection';
    }
  }

  Future<ServiceRatingResponse> addServiceRating(ServiceRatingModel rating) async {
    try {
      if (!_authService.isAuthenticated) {
        return const ServiceRatingResponse(error: 'Please login to continue');
      }

      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken == null) {
        return const ServiceRatingResponse(error: 'Please login to continue');
      }

      log('Sending rating data: ${rating.toJson()}');
      log('Using access token: $accessToken');  // Add token logging

      final response = await _dio.post(
        '/add_service_rating',
        data: {
          'service_id': rating.serviceId,
          'rating': rating.rating,
          if (rating.comment?.isNotEmpty ?? false) 'comment': rating.comment,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Add rating response status: ${response.statusCode}');
      log('Add rating response data: ${response.data}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return ServiceRatingResponse(
          message: response.data['message'] ?? 'Rating added successfully'
        );
      }

      return ServiceRatingResponse(
        error: response.data['error'] ?? 'Failed to add rating'
      );

    } on DioException catch (e) {
      log('DioException in addServiceRating: ${e.message}');
      log('DioException response: ${e.response?.data}');
      return ServiceRatingResponse(
        error: _handleDioError(e),
      );
    } catch (e) {
      log('Error in addServiceRating: $e');
      return ServiceRatingResponse(
        error: 'An unexpected error occurred while adding rating',
      );
    }
  }

  Future<ServiceRatingList> getServiceRatings() async {
    try {
     

      final response = await _dio.get(
        '/view_service_rating',
        options: Options(
          headers: {
            
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Get ratings response: ${response.data}');

      if (response.statusCode == 200) {
        return ServiceRatingList.fromJson(response.data);
      }

      throw Exception(
        response.data['error'] ?? 'Failed to fetch ratings'
      );
    } on DioException catch (e) {
      log('Error fetching ratings: ${e.message}');
      throw Exception(_handleDioError(e));
    }
  }
}

@riverpod
ReviewService reviewService( ref) {
  final authService = ref.watch(apiServiceProvider);
  return ReviewService(authService: authService);
}