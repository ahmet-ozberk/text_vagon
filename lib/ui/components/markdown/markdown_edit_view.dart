// ignore_for_file: depend_on_referenced_packages

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';

import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class MarkdownEditView extends ConsumerStatefulWidget {
  const MarkdownEditView({super.key});

  @override
  ConsumerState<MarkdownEditView> createState() => _MarkdownEditViewState();
}

class _MarkdownEditViewState extends ConsumerState<MarkdownEditView> {
  double toolbarSize = 28.0;
  bool isOpenMenu = false;

  void onFocusChange(bool hasFocus) {
    if (hasFocus) {
      setState(() {
        isOpenMenu = true;
      });
    } else {
      setState(() {
        isOpenMenu = false;
      });
    }
  }

  Future<void> getToolbarSize() async {
    toolbarSize = await Window.getTitlebarHeight();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame
        .then((value) => ref.read(homeProvider).init());
    getToolbarSize();
  }

  @override
  Widget build(BuildContext context) {
    final read = ref.read(homeProvider);
    final watch = ref.watch(homeProvider);
    double lineWidth() {
      if (watch.rowCount < 999) {
        return 42;
      } else if (watch.rowCount > 999 && watch.rowCount < 9999) {
        return 56.0;
      } else {
        return 70.0;
      }
    }

    return Column(
      children: [
        Container(
          height: toolbarSize,
          padding: const EdgeInsets.only(right: 12, top: 4),
          width: double.infinity,
          alignment: Alignment.topRight,
          child: Text(
            "${AppString.word}: ${watch.markdownData.split(" ").length}, ${AppString.character}: ${watch.markdownData.length}, ${AppString.line}: ${watch.cursorLocation}",
            style: context.labelSmall.copyWith(fontWeight: FontWeight.w200),
          ),
        ),
        Expanded(
          child: CodeTheme(
            data: CodeThemeData(
              styles:
                  context.isDarkTheme ? atomOneDarkTheme : atomOneLightTheme,
            ),
            child: CodeField(
              background: Colors.transparent,
              padding: EdgeInsets.zero,
              controller: read.markdownController,
              hintText: "# ${AppString.markdownHintText}",
              hintStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w200,
                color: context.isDarkTheme ? Colors.white : Colors.black,
                fontSize: watch.appFontSize,
              ),
              textStyle: GoogleFonts.montserrat(
                fontWeight: FontWeight.w200,
                color: context.isDarkTheme ? Colors.white : Colors.black,
                fontSize: watch.appFontSize,
              ),
              lineNumberStyle: LineNumberStyle(
                width: lineWidth(),
                textStyle: TextStyle(
                  color: context.isDarkTheme
                      ? Colors.grey.shade600
                      : Colors.grey.shade600,
                ),
              ),
              focusNode: read.markdownFocusNode,
              maxLines: null,
              expands: true,
              cursorColor: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }

  Widget button(
      {required String icon,
      required String label,
      required VoidCallback onTap}) {
    final color =
        context.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade200;
    return GrockContainer(
      onTap: onTap,
      padding: 4.padding,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: 12.borderRadiusOnlyRight,
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label).paddingOnlyLeft(4),
          SvgPicture.asset(
            icon,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(
              context.isDarkTheme ? Colors.grey.shade300 : Colors.black,
              BlendMode.srcIn,
            ),
          ).paddingOnlyRight(4),
        ],
      ),
    );
  }
}
