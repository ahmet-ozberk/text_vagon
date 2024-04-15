import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/enum/view_enum.dart';
import 'package:text_vagon/ui/components/bottom_bar/app_bottom_bar.dart';
import 'package:text_vagon/ui/components/markdown/markdown_edit_view.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';
import 'package:text_vagon/ui/screen/home/widget/horizontal_markdown.dart';
import 'package:text_vagon/ui/screen/home/widget/vertical_markdown.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeProvider);
    return Scaffold(
      floatingActionButton: const AppBottomBar(),
      floatingActionButtonLocation: ExpandableFab.location,
      backgroundColor: Colors.transparent.withOpacity(0),
      /*
        /// Kısayollar için aşağıdaki şekilde tanımlama yapılmalı ve app_shortcuts.dart dosyasında
        /// tanımlı fonksiyonun açılması gerekmektedir.
        
        CallbackShortcuts(
          bindings: AppShortcuts.execute(read),
          child: ...
        ),
      */
      body: watch.viewEnum == ViewEnum.markdown
          ? AnimatedCrossFade(
              firstChild: const VerticalMarkdown(),
              secondChild: const HorizontalMarkdown(),
              crossFadeState: watch.isVerticalMarkdown
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: 400.milliseconds,
            )
          : const MarkdownEditView(),
    );
  }
}
