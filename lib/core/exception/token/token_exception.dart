class TokenStorageException implements Exception {
  final String message;
  final dynamic originalError;
  
  TokenStorageException(this.message, [this.originalError]);
  
  @override
  String toString() {
    if (originalError != null) {
      return 'TokenStorageException: $message (Caused by: $originalError)';
    }
    return 'TokenStorageException: $message';
  }
}