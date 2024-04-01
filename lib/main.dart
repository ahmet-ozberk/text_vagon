import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/local_db/getstorage_manager.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/theme_widget/provider/theme_provider.dart';
import 'package:text_vagon/ui/screen/home/view/home_view.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
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
  runApp(const ProviderScope(child: TextVagonApp()));
}

class TextVagonApp extends StatelessWidget {
  const TextVagonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final watch = ref.watch(themeProvider);
        final read = ref.read(themeProvider);
        read.windowEffect();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: NoThumbScrollBehavior().copyWith(scrollbars: false),
          navigatorKey: Grock.navigationKey,
          scaffoldMessengerKey: Grock.scaffoldMessengerKey,
          title: AppString.appName,
          themeMode: watch.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const HomeView(),
        );
      },
    );
  }
}

class NoThumbScrollBehavior extends ScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.invertedStylus,
      };
}
