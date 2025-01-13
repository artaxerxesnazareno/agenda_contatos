class DatabaseException implements Exception {
  final String message;
  
  DatabaseException(this.message);
  
  @override
  String toString() => message;
}

class ContactNotFoundException implements Exception {
  final String message;
  
  ContactNotFoundException(this.message);
  
  @override
  String toString() => message;
} 