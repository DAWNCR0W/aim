import 'package:flutter/material.dart';
import 'core/database/app_database.dart';
import 'features/main/presentation/pages/main_page.dart';
import 'features/regist/presentation/pages/regist_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final savedUser = await database.localUserDao.getUser();
  runApp(
    MyApp(
      initialPage: savedUser != null ? const MainPage() : const RegistPage(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget initialPage;

  const MyApp({Key? key, required this.initialPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: '회원가입 예제', home: initialPage);
  }
}
