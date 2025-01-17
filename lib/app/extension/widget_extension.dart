import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:text_vagon/app/constant/markdown_view_constant.dart';

extension FabExtension on FloatingActionButton {
  Widget get custom => Theme(
        data: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 10,
            backgroundColor: Colors.grey.shade200,
            shape: RoundedRectangleBorder(
              borderRadius:
                  MarkdownViewConstant.buttonChildrenBorderRadius.borderRadius,
            ),
          ),
        ),
        child: this,
      );
}
