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

  String? get activeEffect =>
      GetStorageManager.read<String>('WindowEffect') ?? WindowEffect.mica.name;

  void setThemeMode(ThemeMode themeMode) {
    GetStorageManager.write('themeMode', themeMode.index);
    windowEffect();
    notifyListeners();
  }

  void windowEffect({WindowEffect? effect}) async {
    final isDarkTheme = themeMode == ThemeMode.system
        ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
        : themeMode == ThemeMode.dark;

    await Window.setEffect(
      effect: activeEffect.windowEffect,
      dark: isDarkTheme,
    );

    await Window.overrideMacOSBrightness(dark: isDarkTheme);
  }

  void setNewEffect(WindowEffect effect) async {
    final isDarkTheme = themeMode == ThemeMode.system
        ? PlatformDispatcher.instance.platformBrightness == Brightness.dark
        : themeMode == ThemeMode.dark;
    await GetStorageManager.write("WindowEffect", effect.name);
    await Window.setEffect(
      effect: effect,
      dark: isDarkTheme,
    );
    notifyListeners();
  }
}

extension WindowEffectExtension on String? {
  WindowEffect get windowEffect {
    final list = WindowEffect.values
        .where((element) => element.name.toLowerCase() == this?.toLowerCase())
        .toList();
    return list.isEmpty ? WindowEffect.mica : list.first;
  }
}
