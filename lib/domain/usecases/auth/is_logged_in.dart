import '../../repositories/auth_repository.dart';

class IsLoggedIn {
  final AuthRepository repository;

  IsLoggedIn({required this.repository});

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}