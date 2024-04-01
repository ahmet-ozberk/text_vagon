import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_vagon/app/local_db/getstorage_manager.dart';

final themeProvider = ChangeNotifierProvider((ref) => ThemeProvider());

class ThemeProvider extends ChangeNotifier {
  ThemeMode get themeMode => GetStorageManager.read<int>('themeMode') == null
      ? ThemeMode.system
      : ThemeMode.values[GetStorageManager.read<int>('themeMode')!];

  void setThemeMode(ThemeMode themeMode) {
    GetStorageManager.write('themeMode', themeMode.index);
    windowEffect();
    notifyListeners();
  }

  void windowEffect() async {
    final isDarkTheme = themeMode == ThemeMode.system
        ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
        : themeMode == ThemeMode.dark;

    await Window.setEffect(
      effect: WindowEffect.mica,
      dark: isDarkTheme,
    );
    await Window.overrideMacOSBrightness(dark: isDarkTheme);
   
  }
}
