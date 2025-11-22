import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'themeMode';

  ThemeMode get themeMode {
    final int? storedMode = _box.read(_key);
    if (storedMode == null) return ThemeMode.system;
    return ThemeMode.values[storedMode];
  }

  void saveThemeMode(ThemeMode mode) {
    _box.write(_key, mode.index);
  }

  void changeThemeMode(ThemeMode mode) {
    Get.changeThemeMode(mode);
    saveThemeMode(mode);
  }
}
