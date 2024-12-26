class CartException implements Exception {
  final String message;
  const CartException(this.message);

  @override
  String toString() => message;
}