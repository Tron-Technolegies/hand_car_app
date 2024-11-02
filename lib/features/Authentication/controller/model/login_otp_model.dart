// Model for OTP verification request
class OtpVerificationRequest {
  final String phone;
  final String otp;

  OtpVerificationRequest({
    required this.phone,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'otp': otp,
    };
  }
}



