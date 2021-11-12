import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_animated_app/screens/home_screen.dart';
import 'package:todo_animated_app/services/db_helper.dart';
import 'package:todo_animated_app/services/theme_service.dart';
import 'package:todo_animated_app/shared/app_binding.dart';
import 'package:todo_animated_app/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper.init();
  runApp(const MyApp());
  // GetStorage().erase();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      title: 'Todo App',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().themeMode,
      home: const HomeScreen(),
    );
  }
}
