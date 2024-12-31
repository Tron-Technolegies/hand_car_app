class AddressException implements Exception {
  final String message;
  AddressException(this.message);
  
  @override
  String toString() => 'AddressException: $message';
}