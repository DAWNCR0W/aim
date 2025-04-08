import 'package:floor/floor.dart';

@entity
class LocalUser {
  @primaryKey
  final String id;
  final String password;
  final String phone;
  final String email;

  LocalUser({
    required this.id,
    required this.password,
    required this.phone,
    required this.email,
  });
}
