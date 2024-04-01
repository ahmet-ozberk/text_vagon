
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/enum/markdown_view_enum.dart';
import 'package:text_vagon/ui/components/markdown/markdown_edit_view.dart';
import 'package:text_vagon/ui/components/markdown_result/markdown_result_view.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class HorizontalMarkdown extends ConsumerStatefulWidget {
  const HorizontalMarkdown({super.key});

  @override
  ConsumerState<HorizontalMarkdown> createState() => _HorizontalMarkdownState();
}

class _HorizontalMarkdownState extends ConsumerState<HorizontalMarkdown> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeProvider);
    return Row(
      children: [
        if (watch.markdownLocation == MarkdownLocation.leftToRight) ...[
          Expanded(
            flex: watch.horizontalEditorFlex,
            child: const MarkdownEditView(),
          ),
          Expanded(
            flex: watch.horizontalResultFlex,
            child: const MarkdownResultView(),
          ),
        ],
        if (watch.markdownLocation == MarkdownLocation.rightToLeft) ...[
          Expanded(
            flex: watch.horizontalResultFlex,
            child: const MarkdownResultView(),
          ),
          Expanded(
            flex: watch.horizontalEditorFlex,
            child: const MarkdownEditView(),
          ),
        ],
      ].seperatedWidget((context, index) => VerticalDivider(width: 0,color: context.isDarkTheme ? Colors.grey.shade800.withOpacity(0.4) : Colors.black12)),
    );
  }
}
