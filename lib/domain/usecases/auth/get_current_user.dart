import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../entities/user.dart';
import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class GetCurrentUser implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUser({required this.repository});

  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}