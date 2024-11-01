// Base response model for handling API responses
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final String? error;

  ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: !json.containsKey('error'),
      message: json['message'] ?? json['error'] ?? '',
      data: json['data'],
      error: json['error'],
    );
  }
}