import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:text_vagon/app/extension/context_extension.dart';

import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class MarkdownResultView extends ConsumerWidget {
  const MarkdownResultView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeProvider);
    return MarkdownWidget(
      data: watch.markdownData,
      padding: const EdgeInsets.all(16),
      config: config(context),
      markdownGenerator: MarkdownGenerator(
        extensionSet: md.ExtensionSet.gitHubFlavored,
      ),
      selectable: true,
    );
  }

  MarkdownConfig config(BuildContext context) {
    final dt = MarkdownConfig.darkConfig;
    final lt = MarkdownConfig.defaultConfig;
    if (context.isDarkTheme) {
      return dt;
    } else {
      return lt;
    }
  }
}
