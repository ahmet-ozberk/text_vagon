import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

final class MarkdownViewConstant {
  static const double seperatedWidgetWidth = 1;
  static const double buttonBorderRadius = 24.0;
  static const double buttonChildrenBorderRadius = 20.0;
  static const double fabDefaultSize = 56.0;
  static const double bottomOverlayBLur = 8.0;
  static final expandableFabKey = GlobalKey<ExpandableFabState>();

  static const String defaultText = '''## Tables
> tables


| Left columns  | Right columns |
| ------------- |:-------------:|
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |

## Blocks of code

```dart
int get verticalEditorFlex => _verticalEditorFlex;
int get verticalResultFlex => _verticalResultFlex;

void function(){
  final value = "12";
  final news = 45;
  final doubleva = true;  
}
```

## Inline code

This web site is using `markedjs/marked`.
## Tables

| Left columns  | Right columns |
| ------------- |:-------------:|
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |

## Blocks of code

```dart
int get verticalEditorFlex => _verticalEditorFlex;
int get verticalResultFlex => _verticalResultFlex;
```

## Inline code

This web site is using `markedjs/marked`.''';
}
