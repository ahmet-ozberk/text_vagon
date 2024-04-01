import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
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
        const Divider(),
        const Text("Pencere Efekti", style: TextStyle(color: Colors.blueGrey)).align(align: Alignment.centerLeft).paddingHorizontal(16),
        SizedBox(
          height: 56,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            padding: 8.padding,
            itemCount: WindowEffect.values.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final effect = WindowEffect.values[index];
              final isActive = watch.activeEffect == effect.name;
              return InkWell(
                onTap: () {
                  read.setNewEffect(effect);
                },
                child: Container(
                  height: 56,
                  padding: 12.paddingHorizontal,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(isActive ? 0.9 : 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      effect.toString().split('.').last,
                      style: context.bodyMedium.copyWith(color: isActive ? Colors.white : Colors.blueGrey),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ).paddingBottomHorizontal(24);
  }
}
