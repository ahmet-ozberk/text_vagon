import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/starter/starter.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/theme_widget/provider/theme_provider.dart';
import 'package:text_vagon/ui/screen/home/view/home_view.dart';

Future<void> main() async {
  await Starter.init();
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

class NoThumbScrollBehavior extends CupertinoScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.invertedStylus,
      };

      @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
