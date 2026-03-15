import 'package:flutter/material.dart';

class CustomDescriptionText extends StatelessWidget {
  final String text;
  final int maxLines;
  final TextStyle? style;
  final TextOverflow overflow;
  final TextAlign textAlign;

  const CustomDescriptionText({
    required this.text, super.key,
    this.maxLines = 3,
    this.style,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: style ?? const TextStyle(fontSize: 14, color: Colors.black87),
    );
  }
}
