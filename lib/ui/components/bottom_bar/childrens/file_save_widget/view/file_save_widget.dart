import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';
import 'package:text_vagon/ui/components/base_bottomsheet/base_bottomsheet.dart';
import 'package:text_vagon/ui/components/bottom_bar/childrens/file_save_widget/provider/file_save_provider.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class FileSaveWidget extends ConsumerWidget {
  const FileSaveWidget({super.key});
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
          return const FileSaveWidget();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final fileSaveRead = ref.read(fileSaveProvider);
    final homeWatch = ref.watch(homeProvider);
    return BaseBottomSheet(
      children: [
        12.height,
        Text(
          AppString.fileSaveOrOpen,
          style: context.titleMedium.copyWith(color: Colors.blueGrey),
        ).paddingHorizontal(16),
        TextField(
          controller: fileSaveRead.fileNameController,
          decoration: InputDecoration(
            hintText: AppString.fileName,
            border: const UnderlineInputBorder(),
            contentPadding: 8.padding,
          ),
        ).paddingAll(16),
        24.height,
        CupertinoButton.filled(
          child: const Text(AppString.save),
          onPressed: () => fileSaveRead.saveFile(homeWatch.markdownData),
        ).disableMaterial3.size(width: double.infinity).paddingHorizontal(24),
        24.height,
        CupertinoButton.filled(
          child: const Text(AppString.openFile),
          onPressed: () {
            fileSaveRead.openFile().then((value) async {
              if (value != null) {
                if (value.path.isNotEmpty) {
                  await value.readAsString().then((value) {
                    homeWatch.setMarkdownData = value;
                    homeWatch.markdownController.text = value;
                  });
                }
                Grock.back();
              } else {
                showCupertinoDialog(
                  context: context,
                  builder: (context) {
                    return CupertinoAlertDialog(
                      title: Column(
                        children: [
                          const FlutterLogo(size: 48),
                          8.height,
                          const Text("Hata"),
                        ],
                      ),
                      content: const Text("Dosya Açılamadı"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("Tamam"),
                          onPressed: () {
                            Grock.back();
                          },
                        ).disableMaterial3,
                      ],
                    );
                  },
                );
              }
            });
          },
        ).disableMaterial3.size(width: double.infinity).paddingHorizontal(24),
        24.height,
      ],
    ).paddingBottomHorizontal(24);
  }
}
