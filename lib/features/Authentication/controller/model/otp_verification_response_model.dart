class OtpVerificationResponse {
  final bool success;
  final String? message;
  final String? error;

  OtpVerificationResponse({
    required this.success,
    this.message,
    this.error,
  });

  factory OtpVerificationResponse.fromJson(Map<String, dynamic> json) {
    return OtpVerificationResponse(
      success: json['success'] ?? false,
      message: json['message'],
      error: json['error'],
    );
  }
}