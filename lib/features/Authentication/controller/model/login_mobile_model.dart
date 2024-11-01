// Model for initial phone number submission
class PhoneLoginRequest {
  final String phone;

  PhoneLoginRequest({required this.phone});

  Map<String, dynamic> toJson() {
    return {
      'phone': phone.replaceAll(RegExp(r'[^0-9]'), ''),
    };
  }
}