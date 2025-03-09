import 'package:flutter/material.dart';
import 'colors.dart';
import 'constant_key.dart';

class GlobalText extends StatelessWidget {
  final String str;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? color;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final bool? softwrap;
  final double? height;
  final String? fontFamily;
  final bool isSelectable;
  final List<TextSpan>? textSpans;

  const GlobalText({
    super.key,
    required this.str,
    this.fontWeight,
    this.fontSize = 16, // Default fontSize to 16
    this.fontStyle,
    this.color,
    this.letterSpacing,
    this.decoration,
    this.maxLines,
    this.textAlign = TextAlign.center, // Default textAlign to center
    this.overflow,
    this.softwrap,
    this.height,
    this.fontFamily,
    this.isSelectable = true,
    this.textSpans,
  });

  @override
  Widget build(BuildContext context) {
    final h = height ?? .08;
    final fw = fontSize ?? 16;
    final double fontHeight = h * fw;

    final textStyle = TextStyle(
      color: color ?? ColorRes.primaryColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      decoration: decoration,
      height: height == null ? null : fontHeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily ?? AppConstantKey.fontFamily.key,
    );

    return isSelectable
        ? SelectableText.rich(
            TextSpan(
              text: str.trim(), // Apply trim() here
              style: textStyle,
              children: textSpans?.map((span) {
                return TextSpan(
                  text: span.text?.trim(), // Apply trim() for each TextSpan
                  style: span.style,
                );
              }).toList(),
            ),
            maxLines: maxLines,
            textAlign: textAlign,
          )
        : RichText(
            text: TextSpan(
              text: str.trim(), // Apply trim() here
              style: textStyle,
              children: textSpans?.map((span) {
                return TextSpan(
                  text: span.text?.trim(), // Apply trim() for each TextSpan
                  style: span.style,
                );
              }).toList(),
            ),
            maxLines: maxLines,
            textAlign: textAlign ?? TextAlign.center,
            softWrap: softwrap ?? true,
          );
  }
}
