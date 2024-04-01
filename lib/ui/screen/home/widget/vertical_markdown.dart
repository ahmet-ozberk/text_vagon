import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/enum/markdown_view_enum.dart';
import 'package:text_vagon/ui/components/markdown/markdown_edit_view.dart';
import 'package:text_vagon/ui/components/markdown_result/markdown_result_view.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class VerticalMarkdown extends ConsumerStatefulWidget {
  const VerticalMarkdown({super.key});

  @override
  ConsumerState<VerticalMarkdown> createState() => _VerticalMarkdownState();
}

class _VerticalMarkdownState extends ConsumerState<VerticalMarkdown> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeProvider);
    return Column(
      children: [
        if (watch.markdownLocation == MarkdownLocation.topToBottom) ...[
          Expanded(
            flex: watch.verticalEditorFlex,
            child: const MarkdownEditView(),
          ),
          Expanded(
            flex: watch.verticalResultFlex,
            child: const MarkdownResultView(),
          ),
        ],
        if (watch.markdownLocation == MarkdownLocation.bottomToTop) ...[
          Expanded(
            flex: watch.verticalResultFlex,
            child: const MarkdownResultView(),
          ),
          Expanded(
            flex: watch.verticalEditorFlex,
            child: const MarkdownEditView(),
          ),
        ],
      ].seperatedWidget((context, index) => Divider(height: 0,color: context.isDarkTheme ? Colors.grey.shade800.withOpacity(0.4) : Colors.black12)),
    );
  }
}
