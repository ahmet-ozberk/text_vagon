import 'package:flutter/material.dart';
import 'package:text_vagon/app/local_db/getstorage_manager.dart';

final class MarkdownPatterns {
  MarkdownPatterns._();

  static final MarkdownPatterns instance = MarkdownPatterns._();

  double get newSize => GetStorageManager.read<double?>("fontSize") ?? 0;

  Map<String, TextStyle> get patternMap {
    print("newSize: $newSize");
    return {
      r'#.*': TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
          fontSize: 24 + newSize),
      r'```.*': TextStyle(
          color: Colors.green.shade800,
          fontWeight: FontWeight.bold,
          fontSize: 12 + newSize),
      r'[a-zA-Z0-9]+\(.*\)':
          const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
      r'{': const TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
      r'}': const TextStyle(color: Colors.blue, fontWeight: FontWeight.w300),
    };
  }

  Map<String, TextStyle> get stringMap => {
        "Allah": TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20 + newSize),
        "ahmet özberk": const TextStyle(
            fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
        "void":
            const TextStyle(fontWeight: FontWeight.normal, color: Colors.red),
      };
}
