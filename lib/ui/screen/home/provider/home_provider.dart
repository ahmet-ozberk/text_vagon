// ignore_for_file: depend_on_referenced_packages

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_vagon/app/constant/app_string.dart';
import 'package:text_vagon/app/enum/markdown_view_enum.dart';
import 'package:text_vagon/app/enum/view_enum.dart';
import 'package:text_vagon/ui/components/markdown/markdown_patterns.dart';
import 'package:text_vagon/ui/screen/home/model/markdown_layout_model.dart';
import 'package:highlight/languages/dart.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  String _markdownData = '''# ${AppString.markdownHintText} ''';
  ViewEnum _viewEnum = ViewEnum.markdown;
  MarkdownLayoutModel _markdownLayoutModel = MarkdownLayoutModel();
  MarkdownLocation _markdownLocation = MarkdownLocation.leftToRight;
  //double? localFontSize = GetStorageManager.read<double?>("fontSize");
  final CodeController _markdownController = CodeController(
      language: dart,
      patternMap: MarkdownPatterns.instance.patternMap,
      stringMap: MarkdownPatterns.instance.stringMap,
      params: const EditorParams(tabSpaces: 4));
  final _markdownFocusNode = FocusNode();
  final lineScrollController = ScrollController();
  final markdownScrollController = ScrollController();
  int rowCount = 1;

  int _horizontalEditorFlex = 1;
  int _horizontalResultFlex = 1;
  int _verticalEditorFlex = 1;
  int _verticalResultFlex = 1;

  MarkdownLocation get markdownLocation => _markdownLocation;
  MarkdownLayoutModel get markdownLayoutModel => _markdownLayoutModel;
  CodeController get markdownController => _markdownController;
  FocusNode get markdownFocusNode => _markdownFocusNode;
  int get markdownLineCount => rowCount;
  String get markdownData => _markdownData;
  int get horizontalEditorFlex => _horizontalEditorFlex;
  int get horizontalResultFlex => _horizontalResultFlex;
  int get verticalEditorFlex => _verticalEditorFlex;
  int get verticalResultFlex => _verticalResultFlex;
  ViewEnum get viewEnum => _viewEnum;

  // double get appFontSize => localFontSize ?? 16;

  double get appFontSize => 16;

  int get cursorLocation {
    final baseOffset = _markdownController.selection.baseOffset;
    return _calculateLineNumber(baseOffset < 0 ? 0 : baseOffset);
  }

  set setViewEnum(ViewEnum viewEnum) {
    _viewEnum = viewEnum;
    notifyListeners();
  }

  set setHorizontalEditorFlex(int horizontalEditorFlex) {
    _horizontalEditorFlex = horizontalEditorFlex;
    notifyListeners();
  }

  set setHorizontalResultFlex(int horizontalResultFlex) {
    _horizontalResultFlex = horizontalResultFlex;
    notifyListeners();
  }

  set setVerticalEditorFlex(int verticalEditorFlex) {
    _verticalEditorFlex = verticalEditorFlex;
    notifyListeners();
  }

  set setVerticalResultFlex(int verticalResultFlex) {
    _verticalResultFlex = verticalResultFlex;
    notifyListeners();
  }

  set setMarkdownLocation(MarkdownLocation markdownLocation) {
    _markdownLocation = markdownLocation;
    notifyListeners();
  }

  set setMarkdownLayoutModel(MarkdownLayoutModel markdownLayoutModel) {
    _markdownLayoutModel = markdownLayoutModel;
    notifyListeners();
  }

  set setMarkdownData(String markdownData) {
    _markdownData = markdownData;
    notifyListeners();
  }

  void listenerMarkdownText() {
    _markdownController.addListener(() {
      _markdownData = _markdownController.text;
      rowCount = '\n'.allMatches(_markdownData).length + 1;
      notifyListeners();
    });
  }

  void init() {
    listenerMarkdownText();
    markdownScrollController.addListener(() {
      lineScrollController.jumpTo(markdownScrollController.offset);
    });
  }

  int _calculateLineNumber(int cursorPosition) {
    try {
      if (cursorPosition < 0) {
        cursorPosition = 0;
      }
      final textBeforeCursor =
          _markdownController.text.substring(0, cursorPosition);
      final newLineRegex = RegExp(r'\n');
      final matches = newLineRegex.allMatches(textBeforeCursor);
      return matches.length + 1;
    } catch (e) {
      return 1;
    }
  }

  bool get isVerticalMarkdown =>
      _markdownLocation == MarkdownLocation.topToBottom ||
      _markdownLocation == MarkdownLocation.bottomToTop;
}



  // void incrementFontSize() {
  //   if (localFontSize != null) {
  //     if (localFontSize! < 24) {
  //       localFontSize = localFontSize! + 1;
  //       settingsFontSize();
  //     }
  //   }
  // }

  // void decrementFontSize() {
  //   if (localFontSize != null) {
  //     if (localFontSize! > -8) {
  //       localFontSize = localFontSize! - 1;
  //       settingsFontSize();
  //     }
  //   }
  // }

  // void settingsFontSize() {
  //   GetStorageManager.write("fontSize", localFontSize);
  //   _markdownController.copyWith(
  //     patternMap: MarkdownPatterns.instance.patternMap,
  //     stringMap: MarkdownPatterns.instance.stringMap,
  //   );
  //   Grock.toast(
  //       text: "${appFontSize.toInt()}",
  //       duration: 700.milliseconds,
  //       openDuration: 200.milliseconds,
  //       backgroundColor: Colors.grey.shade300,
  //       textColor: Colors.black);
  //   notifyListeners();
  // }
