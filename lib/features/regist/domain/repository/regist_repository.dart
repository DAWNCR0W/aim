import '../entities/regist_user.dart';

abstract class RegistRepository {
  Future<void> register(RegistUser user);
}