import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_interaction_service.g.dart';

class ServiceInteractionApi {
  final Dio _dio;

  ServiceInteractionApi()
      : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add any auth tokens or headers here
          return handler.next(options);
        },
        onError: (DioException error, handler) {
          // Handle errors here
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> logInteraction(String serviceId, String action) async {
    try {
      log('Logging interaction - serviceId: $serviceId, action: $action');

      // Create form data
      final formData = FormData.fromMap({
        'action': action,
        'service_id': serviceId,
      });

      final response = await _dio.post(
        '/log_service_interaction',
        data: formData,
      );

      log('Log interaction response: ${response.data}');

      if (response.statusCode == 201) {
        log('Interaction logged successfully');
        return true;
      } else {
        log('Failed to log interaction: ${response.data['error']}');
        return false;
      }
    } catch (e) {
      log('Error logging interaction: $e');
      return false;
    }
  }
}

@riverpod
ServiceInteractionApi serviceInteractionApi(ref) {
  return ServiceInteractionApi();
}

@riverpod
Future<bool> logInteraction(
  ref,
  String serviceId,
  String action,
) async {
  final api = ref.watch(serviceInteractionApiProvider);
  return await api.logServiceInteraction(serviceId, action);
}
