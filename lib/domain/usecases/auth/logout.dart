import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repositories/auth_repository.dart';
import '../usecase.dart';

class Logout implements UseCase<void, NoParams> {
  final AuthRepository repository;

  Logout({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.logout();
  }
}