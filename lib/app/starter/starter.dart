import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:text_vagon/app/local_db/getstorage_manager.dart';
import 'package:window_manager/window_manager.dart';

final class Starter {
  Starter._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await GetStorageManager.init();
    await Window.initialize();
    await Window.makeTitlebarTransparent();
    await Window.enableFullSizeContentView();
    await Window.hideTitle();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 700),
      minimumSize: Size(600, 400),
      center: true,
      backgroundColor: Colors.transparent,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
}
