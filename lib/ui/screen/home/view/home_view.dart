import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/shortcuts/app_shortcuts.dart';
import 'package:text_vagon/ui/components/bottom_bar/app_bottom_bar.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';
import 'package:text_vagon/ui/screen/home/widget/horizontal_markdown.dart';
import 'package:text_vagon/ui/screen/home/widget/vertical_markdown.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeProvider);
    final read = ref.read(homeProvider);
    return Scaffold(
      floatingActionButton: const AppBottomBar(),
      floatingActionButtonLocation: ExpandableFab.location,
      backgroundColor: Colors.transparent.withOpacity(0),
      body: CallbackShortcuts(
        bindings: AppShortcuts.execute(read),
        child: AnimatedCrossFade(
          firstChild: const VerticalMarkdown(),
          secondChild: const HorizontalMarkdown(),
          crossFadeState: watch.isVerticalMarkdown
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: 400.milliseconds,
        ),
      ),
    );
  }
}
