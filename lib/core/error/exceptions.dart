// Custom exceptions
class ServerException implements Exception {
  final String message;
  
  ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  
  CacheException({required this.message});
}

class NetworkException implements Exception {
  final String message;
  
  NetworkException({required this.message});
}

class UnauthorizedException implements Exception {
  final String message;
  
  UnauthorizedException({required this.message});
}

class NotFoundException implements Exception {
  final String message;
  
  NotFoundException({required this.message});
}

class ValidationException implements Exception {
  final String message;
  
  ValidationException({required this.message});
}

class TimeoutException implements Exception {
  final String message;
  
  TimeoutException({required this.message});
}