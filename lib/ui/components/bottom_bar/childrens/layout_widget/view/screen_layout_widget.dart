import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';
import 'package:text_vagon/app/enum/markdown_view_enum.dart';
import 'package:text_vagon/ui/components/base_bottomsheet/base_bottomsheet.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class ScreenLayoutWidget extends ConsumerWidget {
  const ScreenLayoutWidget({super.key});
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
          return const ScreenLayoutWidget();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(homeProvider);
    final watch = ref.watch(homeProvider);
    return BaseBottomSheet(
      children: [
        12.height,
        Row(
          children: [
            Text(
              "${watch.isVerticalMarkdown ? "Dikey" : "Yatay"} Ekran Yerleşimi",
              style: context.titleMedium.copyWith(color: Colors.blueGrey),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: watch.isVerticalMarkdown,
              onChanged: (value) {
                read.setMarkdownLocation = value
                    ? MarkdownLocation.topToBottom
                    : MarkdownLocation.leftToRight;
              },
            ),
          ],
        ).paddingHorizontal(16),
        ListTile(
          title: CupertinoSlider(
            min: 1,
            max: 20,
            activeColor: Colors.blueGrey,
            value: watch.isVerticalMarkdown
                ? watch.verticalEditorFlex.toDouble()
                : watch.horizontalEditorFlex.toDouble(),
            divisions: 20,
            onChanged: (value) {
              if (watch.isVerticalMarkdown) {
                read.setVerticalEditorFlex = value.toInt();
              } else {
                read.setHorizontalEditorFlex = value.toInt();
              }
            },
          ),
          leading: const Text("Editör ekran"),
        ),
        ListTile(
          title: CupertinoSlider(
            min: 1,
            max: 20,
            activeColor: Colors.blueGrey,
            value: watch.isVerticalMarkdown
                ? watch.verticalResultFlex.toDouble()
                : watch.horizontalResultFlex.toDouble(),
            divisions: 20,
            onChanged: (value) {
              if (watch.isVerticalMarkdown) {
                read.setVerticalResultFlex = value.toInt();
              } else {
                read.setHorizontalResultFlex = value.toInt();
              }
            },
          ),
          leading: const Text("Sonuç ekran"),
        ),
      ],
    ).paddingBottomHorizontal(24);
  }
}
