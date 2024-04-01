import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:min_animations/min_animations.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';
import 'package:text_vagon/app/extension/context_extension.dart';
import 'package:text_vagon/app/extension/widget_extension.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/file_save_widget/view/file_save_widget.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/layout_widget/view/screen_layout_widget.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/theme_widget/view/screen_theme_widget.dart';

class AppBottomBar extends ConsumerWidget {
  const AppBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpandableFab(
      key: MarkdownViewConstant.expandableFabKey,
      type: ExpandableFabType.side,
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
          blur: MarkdownViewConstant.bottomOverlayBLur),
      openButtonBuilder: FloatingActionButtonBuilder(
        size: MarkdownViewConstant.fabDefaultSize,
        builder: (context, onPressed, progress) {
          return MinFlipAnimation(
            begin: 3.14159,
            end: 0,
            duration: 200.milliseconds,
            child: openCLoseFab(onPressed, context),
          );
        },
      ),
      closeButtonBuilder: FloatingActionButtonBuilder(
        size: MarkdownViewConstant.fabDefaultSize,
        builder: (context, onPressed, progress) {
          return MinFlipAnimation(
            duration: 200.milliseconds,
            child: openCLoseFab(onPressed, context),
          );
        },
      ),
      children: [
        FloatingActionButton(
          onPressed: () => FileSaveWidget.show(),
          tooltip: "Aç veya Kaydet",
          child: const Icon(Icons.save_as_rounded),
        ).custom,
        FloatingActionButton(
          onPressed: () => ScreenLayoutWidget.show(),
          tooltip: "Ekran Yerleşimi",
          child: const Icon(Icons.width_normal_rounded),
        ).custom,
        FloatingActionButton(
          onPressed: () => ScreenThemeWidget.show(),
          tooltip: "Uygulama Teması",
          child: context.isDarkTheme
              ? const Icon(Icons.dark_mode_rounded)
              : const Icon(Icons.light_mode_rounded),
        ).custom,
      ],
    );
  }

  FloatingActionButton openCLoseFab(
      void Function()? onPressed, BuildContext context) {
    return FloatingActionButton(
      tooltip: "Ayarlar",
      backgroundColor:
          context.isDarkTheme ? Colors.amber.shade900 : Colors.amber,
      shape: RoundedRectangleBorder(
        borderRadius: MarkdownViewConstant.buttonBorderRadius.borderRadius,
      ),
      onPressed: onPressed,
      child: Icon(Icons.menu_open_sharp,
          color: context.isDarkTheme ? Colors.black : Colors.white),
    );
  }
}
