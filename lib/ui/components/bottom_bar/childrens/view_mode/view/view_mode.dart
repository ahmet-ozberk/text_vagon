import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';
import 'package:text_vagon/app/enum/view_enum.dart';
import 'package:text_vagon/assets.dart';
import 'package:text_vagon/ui/components/base_bottomsheet/base_bottomsheet.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class ViewModeWidget extends ConsumerWidget {
  const ViewModeWidget({super.key});
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
          return const ViewModeWidget();
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
        Text(
          AppString.viewMode,
          style: context.titleMedium.copyWith(color: Colors.blueGrey),
        ).paddingHorizontal(16),
        ListTile(
          leading: SvgPicture.asset(Assets.image.svgMarkdownSVG, width: 24),
          title: const Text(AppString.markdown),
          trailing: CupertinoCheckbox(
            value: watch.viewEnum == ViewEnum.markdown,
            onChanged: (value) {
              read.setViewEnum = ViewEnum.markdown;
            },
          ),
        ),
        ListTile(
          leading: SvgPicture.asset(Assets.image.svgCodeSVG, width: 24),
          title: const Text(AppString.code),
          trailing: CupertinoCheckbox(
            value: watch.viewEnum == ViewEnum.code,
            onChanged: (value) {
              read.setViewEnum = ViewEnum.code;
            },
          ),
        ),
      ],
    ).paddingBottomHorizontal(24);
  }
}
