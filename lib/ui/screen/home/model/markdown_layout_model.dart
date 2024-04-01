// ignore_for_file: public_member_api_docs, sort_constructors_first
class MarkdownLayoutModel {
  final double? height;
  final double? width;
  MarkdownLayoutModel({
    this.height,
    this.width,
  });


  MarkdownLayoutModel copyWith({
    double? height,
    double? width,
  }) {
    return MarkdownLayoutModel(
      height: height ?? this.height,
      width: width ?? this.width,
    );
  }
}
