import '../entities/regist_user.dart';
import '../repository/regist_repository.dart';

class RegisterUser {
  final RegistRepository repository;

  RegisterUser(this.repository);

  Future<void> call(RegistUser user) async {
    await repository.register(user);
  }
}
