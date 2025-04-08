import 'package:floor/floor.dart';
import 'local_user.dart';

@dao
abstract class LocalUserDao {
  @Query('SELECT * FROM LocalUser LIMIT 1')
  Future<LocalUser?> getUser();

  @insert
  Future<void> insertUser(LocalUser user);

  @delete
  Future<void> deleteUser(LocalUser user);
}
