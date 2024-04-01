import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';
import 'package:text_vagon/ui/components/base_bottomsheet/base_bottomsheet.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/theme_widget/provider/theme_provider.dart';

class ScreenThemeWidget extends ConsumerWidget {
  const ScreenThemeWidget({super.key});
  static void show() {
    final state = MarkdownViewConstant.expandableFabKey.currentState;
    if (state != null) {
      state.toggle();
      showModalBottomSheet(
        context: Grock.context,
        barrierColor: Colors.transparent.withOpacity(0),
        elevation: 0,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return const ScreenThemeWidget();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(themeProvider);
    final watch = ref.watch(themeProvider);
    return BaseBottomSheet(
      children: [
        12.height,
        Text(
          "Uygulama Teması",
          style: context.titleMedium.copyWith(color: Colors.blueGrey),
        ).paddingHorizontal(16),
        ListTile(
          title: const Text("Açık Tema"),
          trailing: CupertinoSwitch(
            value: watch.themeMode == ThemeMode.light,
            onChanged: (value) {
              if (value) {
                read.setThemeMode(ThemeMode.light);
              }
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text("Koyu Tema"),
          trailing: CupertinoSwitch(
            value: watch.themeMode == ThemeMode.dark,
            onChanged: (value) {
              if (value) {
                read.setThemeMode(ThemeMode.dark);
              }
            },
          ),
        ),
        const Divider(),
        ListTile(
          title: const Text("Sistem Teması"),
          trailing: CupertinoSwitch(
            value: watch.themeMode == ThemeMode.system,
            onChanged: (value) {
              if (value) {
                read.setThemeMode(ThemeMode.system);
              }
            },
          ),
        ),
      ],
    ).paddingBottomHorizontal(24);
  }
}
