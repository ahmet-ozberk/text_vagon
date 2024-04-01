import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:text_vagon/app/enum/markdown_view_enum.dart';
import 'package:text_vagon/ui/screen/home/model/markdown_layout_model.dart';

final homeProvider = ChangeNotifierProvider((ref) => HomeProvider());

class HomeProvider extends ChangeNotifier {
  String _markdownData = '''# Enter Markdown ''';
  MarkdownLayoutModel _markdownLayoutModel = MarkdownLayoutModel();
  MarkdownLocation _markdownLocation = MarkdownLocation.leftToRight;
  final _markdownController = TextEditingController();
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
  TextEditingController get markdownController => _markdownController;
  FocusNode get markdownFocusNode => _markdownFocusNode;
  int get markdownLineCount => rowCount;
  String get markdownData => _markdownData;
  int get horizontalEditorFlex => _horizontalEditorFlex;
  int get horizontalResultFlex => _horizontalResultFlex;
  int get verticalEditorFlex => _verticalEditorFlex;
  int get verticalResultFlex => _verticalResultFlex;

  int get cursorLocation {
    return _calculateLineNumber(_markdownController.selection.baseOffset < 0
        ? 0
        : _markdownController.selection.baseOffset);
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

  void init() {
    listenerMarkdownText();
    markdownScrollController.addListener(() {
      lineScrollController.jumpTo(markdownScrollController.offset);
    });
  }

  bool get isVerticalMarkdown =>
      _markdownLocation == MarkdownLocation.topToBottom ||
      _markdownLocation == MarkdownLocation.bottomToTop;

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    final newWidth = _markdownLayoutModel.width! + details.delta.dx;

    if (_markdownLocation == MarkdownLocation.leftToRight) {
      if (newWidth > 0) {
        _markdownLayoutModel = _markdownLayoutModel.copyWith(
          width: newWidth,
        );
        notifyListeners();
      }
    } else {
      final newWidth = _markdownLayoutModel.width! - details.delta.dx;

      if (newWidth > 0) {
        _markdownLayoutModel = _markdownLayoutModel.copyWith(
          width: newWidth,
        );
        notifyListeners();
      }
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails details) {
    final newHeight = _markdownLayoutModel.height! + details.delta.dy;

    if (_markdownLocation == MarkdownLocation.topToBottom) {
      if (newHeight > 0) {
        _markdownLayoutModel = _markdownLayoutModel.copyWith(
          height: newHeight,
        );
        notifyListeners();
      }
    } else {
      final newHeight = _markdownLayoutModel.height! - details.delta.dy;

      if (newHeight > 0) {
        _markdownLayoutModel = _markdownLayoutModel.copyWith(
          height: newHeight,
        );
        notifyListeners();
      }
    }
  }
}
