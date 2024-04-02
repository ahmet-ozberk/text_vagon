import 'package:flutter/material.dart';
import 'package:grock/grock.dart';
import 'package:min_animations/min_animations.dart';

class BaseBottomSheet extends StatelessWidget {
  final List<Widget> children;
  final Function(Function)? onDismiss;
  const BaseBottomSheet({super.key, required this.children, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: MinScaleAnimation(
        child: Container(
          decoration: BoxDecoration(
            color: context.isDarkTheme ? Colors.grey.shade900 : Colors.white,
            borderRadius: 12.borderRadius,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
