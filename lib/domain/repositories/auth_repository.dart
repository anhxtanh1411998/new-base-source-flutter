import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Login with email and password
  /// Returns [User] if successful, [Failure] otherwise
  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  /// Register a new user
  /// Returns [User] if successful, [Failure] otherwise
  Future<Either<Failure, User>> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logout the current user
  /// Returns [void] if successful, [Failure] otherwise
  Future<Either<Failure, void>> logout();

  /// Get the current logged in user
  /// Returns [User] if successful, [Failure] otherwise
  Future<Either<Failure, User?>> getCurrentUser();

  /// Check if the user is logged in
  /// Returns [bool] indicating if the user is logged in
  Future<bool> isLoggedIn();
}