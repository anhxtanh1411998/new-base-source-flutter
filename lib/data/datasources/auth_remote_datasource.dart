import 'package:dio/dio.dart';

import '../../core/error/error_handler.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Login with email and password
  /// Returns [UserModel] if successful
  /// Throws an exception if there's a server error
  Future<UserModel> login({
    required String email,
    required String password,
  });

  /// Register a new user
  /// Returns [UserModel] if successful
  /// Throws an exception if there's a server error
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout the current user
  /// Returns [void] if successful
  /// Throws an exception if there's a server error
  Future<void> logout();

  /// Get the current logged in user
  /// Returns [UserModel] if successful
  /// Throws an exception if there's a server error
  Future<UserModel?> getCurrentUser();

  /// Check if the user is logged in
  /// Returns [bool] indicating if the user is logged in
  Future<bool> isLoggedIn();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await client.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.post('/auth/logout');
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await client.get('/auth/me');
      return UserModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handleDioError(e);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final response = await client.get('/auth/check');
      return response.data['isLoggedIn'] ?? false;
    } on DioException {
      return false;
    }
  }
}
