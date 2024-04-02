import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grock/grock.dart';
// ignore: depend_on_referenced_packages
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/atom-one-light.dart';
import 'package:text_vagon/ui/screen/home/provider/home_provider.dart';

class MarkdownResultView extends ConsumerStatefulWidget {
  const MarkdownResultView({super.key});

  @override
  ConsumerState<MarkdownResultView> createState() => _MarkdownResultViewState();
}

class _MarkdownResultViewState extends ConsumerState<MarkdownResultView> {
  @override
  Widget build(BuildContext context) {
    final watch = ref.watch(homeProvider);
    return DefaultTextStyle(
      style: GoogleFonts.montserrat(
        fontWeight: FontWeight.w200,
        color: context.isDarkTheme ? Colors.white : Colors.black,
        fontSize: watch.appFontSize,
      ),
      child: MarkdownWidget(
        data: watch.markdownData,
        padding: const EdgeInsets.all(16),
        config: config(context),
        markdownGenerator: MarkdownGenerator(
          extensionSet: md.ExtensionSet.gitHubFlavored,
        ),
        selectable: true,
      ),
    );
  }

  MarkdownConfig config(BuildContext context) {
    final dt = MarkdownConfig.darkConfig;
    final lt = MarkdownConfig.defaultConfig;
    dt.copy(configs: [
      PreConfig(
        theme: atomOneDarkTheme,
        wrapper: (child, code, language) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned(
                top: -12,
                right: 12,
                child: Row(
                  children: [
                    GrockContainer(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        Grock.toast(
                          text: "Kopyalandı!",
                        );
                      },
                      padding: [8, 4].horizontalAndVerticalP,
                      decoration: BoxDecoration(
                        color: const Color(0xff282c34).withOpacity(0.4),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Text(
                        "copy",
                        style: GoogleFonts.montserrat(
                          color: const Color(0xff61afef),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    4.width,
                    Container(
                      padding: [8, 4].horizontalAndVerticalP,
                      decoration: BoxDecoration(
                        color: const Color(0xff282c34).withOpacity(0.4),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Text(
                        language,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        decoration: BoxDecoration(
          color: const Color(0xff282c34).withOpacity(0.4),
          borderRadius: 16.borderRadius,
          border: Border.all(color: const Color(0xff61afef), width: 0.4),
        ),
      ),
    ]);
    lt.copy(configs: [
      PreConfig(
        theme: atomOneLightTheme,
        wrapper: (child, code, language) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              child,
              Positioned(
                top: -12,
                right: 12,
                child: Row(
                  children: [
                    GrockContainer(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: code));
                        Grock.toast(
                          text: "Kopyalandı!",
                        );
                      },
                      padding: [8, 4].horizontalAndVerticalP,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F8F2).withOpacity(0.4),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Text(
                        "copy",
                        style: GoogleFonts.montserrat(
                          color: const Color(0xff61afef),
                          fontSize: 10,
                        ),
                      ),
                    ),
                    4.width,
                    Container(
                      padding: [8, 4].horizontalAndVerticalP,
                      decoration: BoxDecoration(
                        color: const Color(0xffF8F8F2).withOpacity(0.4),
                        borderRadius: 8.borderRadius,
                      ),
                      child: Text(
                        language,
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        decoration: BoxDecoration(
          color: const Color(0xffF8F8F2).withOpacity(0.4),
          borderRadius: 16.borderRadius,
          border: Border.all(color: const Color(0xff61afef), width: 0.4),
        ),
      ),
    ]);
    if (context.isDarkTheme) {
      return dt;
    } else {
      return lt;
    }
  }
}
