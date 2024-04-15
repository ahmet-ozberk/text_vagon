import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/enum/view_enum.dart';
import 'package:text_vagon/assets.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';

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

    return Stack(
      children: [
        Column(
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
                  styles: context.isDarkTheme
                      ? atomOneDarkTheme
                      : atomOneLightTheme,
                ),
                child: CodeField(
                  background: Colors.transparent,
                  controller: read.markdownController,
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

            // Expanded(
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       SingleChildScrollView(
            //         padding: 8.paddingVertical,
            //         controller: read.lineScrollController,
            //         physics: const NeverScrollableScrollPhysics(),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: List.generate(watch.rowCount, (index) {
            //             return Container(
            //               padding: const EdgeInsets.symmetric(horizontal: 8),
            //               child: Center(
            //                 child: Text(
            //                   '${index + 1}',
            //                   style: context.titleLarge.copyWith(
            //                       fontWeight: watch.cursorLocation == (index + 1)
            //                           ? FontWeight.w300
            //                           : FontWeight.w100,
            //                       color: watch.cursorLocation == (index + 1)
            //                           ? context.isDarkTheme
            //                               ? Colors.white
            //                               : Colors.black
            //                           : context.isDarkTheme
            //                               ? Colors.grey.shade600
            //                               : Colors.grey.shade600),
            //                   textAlign: TextAlign.center,
            //                 ),
            //               ),
            //             );
            //           }),
            //         ),
            //       ),
            //       VerticalDivider(
            //           width: 0,
            //           color: context.isDarkTheme
            //               ? Colors.grey.shade800.withOpacity(0.4)
            //               : Colors.black12),
            //       Expanded(
            //         child: TextField(
            //           cursorColor: Colors.blueGrey,
            //           cursorHeight: 28,
            //           scrollController: read.markdownScrollController,
            //           focusNode: read.markdownFocusNode,
            //           controller: read.markdownController,
            //           maxLines: null,
            //           expands: true,
            //           style:  context.titleLarge.copyWith(fontWeight: FontWeight.w200),
            //           decoration: InputDecoration(
            //             contentPadding: 8.padding,
            //             border: InputBorder.none,
            //             hintText: '# ${AppString.markdownHintText}',
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          top: toolbarSize + 24,
          left: isOpenMenu ? 0 : -(120 - 24 - 8).toDouble(),
          child: MouseRegion(
            onHover: (event) => onFocusChange(true),
            onExit: (event) => onFocusChange(false),
            child: DefaultTextStyle(
              style: context.labelSmall,
              child: button(
                  icon: Assets.image.svgMarkdownSVG,
                  label: "Markdown",
                  onTap: () {
                    read.setViewEnum = ViewEnum.markdown;
                  }),
            ),
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          left: isOpenMenu ? 0 : -(120 - 24 - 8).toDouble(),
          top: toolbarSize + 62,
          child: MouseRegion(
            onHover: (event) => onFocusChange(true),
            onExit: (event) => onFocusChange(false),
            child: DefaultTextStyle(
              style: context.labelSmall,
              child: button(
                  icon: Assets.image.svgCodeSVG,
                  label: "Kod",
                  onTap: () {
                    read.setViewEnum = ViewEnum.code;
                  }),
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
    return GrockContainer(
      onTap: onTap,
      padding: 4.padding,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: 12.borderRadiusOnlyRight,
        color:
            context.isDarkTheme ? Colors.grey.shade900 : Colors.grey.shade200,
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
