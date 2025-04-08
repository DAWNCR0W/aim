import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../features/regist/data/models/local_user.dart';
import '../../features/regist/data/models/local_user_dao.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [LocalUser])
abstract class AppDatabase extends FloorDatabase {
  LocalUserDao get localUserDao;
}
