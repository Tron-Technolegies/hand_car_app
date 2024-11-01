// Model for completing user registration with name and email
class CompleteRegistrationRequest {
  final String phone;
  final String name;
  final String email;

  CompleteRegistrationRequest({
    required this.phone,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'name': name,
      'email': email,
    };
  }
}
