import 'package:dio/dio.dart';

import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  // Convert exceptions to failures
  static Failure handleError(Exception exception) {
    if (exception is ServerException) {
      return ServerFailure(message: exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(message: exception.message);
    } else if (exception is NetworkException) {
      return NetworkFailure(message: exception.message);
    } else if (exception is UnauthorizedException) {
      return UnauthorizedFailure(message: exception.message);
    } else if (exception is NotFoundException) {
      return NotFoundFailure(message: exception.message);
    } else if (exception is ValidationException) {
      return ValidationFailure(message: exception.message);
    } else if (exception is TimeoutException) {
      return TimeoutFailure(message: exception.message);
    } else {
      return const UnknownFailure(message: 'Unexpected error occurred');
    }
  }

  // Handle Dio errors
  static Exception handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        return _handleResponseError(error);
      case DioExceptionType.cancel:
        return ServerException(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return NetworkException(message: 'No internet connection');
      case DioExceptionType.unknown:
      default:
        return ServerException(message: 'Something went wrong');
    }
  }

  // Handle response errors
  static Exception _handleResponseError(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;
    
    String errorMessage = 'Something went wrong';
    if (responseData != null && responseData is Map && responseData.containsKey('message')) {
      errorMessage = responseData['message'];
    }

    switch (statusCode) {
      case 400:
        return ValidationException(message: errorMessage);
      case 401:
        return UnauthorizedException(message: 'Unauthorized');
      case 403:
        return UnauthorizedException(message: 'Forbidden');
      case 404:
        return NotFoundException(message: 'Not found');
      case 500:
      case 501:
      case 502:
      case 503:
        return ServerException(message: 'Server error');
      default:
        return ServerException(message: errorMessage);
    }
  }
}