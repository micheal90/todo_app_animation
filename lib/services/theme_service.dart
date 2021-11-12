import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final GetStorage _box = GetStorage();
  final _key = 'isDark';

  ThemeMode get themeMode => readFromBox() ? ThemeMode.dark : ThemeMode.light;

  void swichThemeMode() async {
    bool value = readFromBox();
    Get.changeThemeMode(value ? ThemeMode.light : ThemeMode.dark);
    await saveInBox(!value);
     }

  //save key in storage
  Future saveInBox( bool isDark) async {
    await _box.write(_key, isDark);
  }

  //get key from storage
  bool readFromBox() => _box.read<bool>(_key) ?? false;
}
