import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';

class XText extends StatelessWidget {
  final Key? xKey;
  final String? text;
  final TextStyleEnum? xStyle;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const XText(
    this.text, {
    this.xKey,
    this.xStyle,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: xKey);

  const XText.displayLarge(
    this.text, {
    this.textAlign = TextAlign.start,
    this.xStyle = TextStyleEnum.displayLarge,
    this.style,
    this.xKey,
    this.overflow,
    this.maxLines,
  }) : super(key: xKey);

  const XText.displayMedium(
    this.text, {
    this.xStyle = TextStyleEnum.displayMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.displaySmall(
    this.text, {
    this.xStyle = TextStyleEnum.displaySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.headlineLarge(
    this.text, {
    this.xStyle = TextStyleEnum.headlineLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.headlineMedium(
    this.text, {
    this.xStyle = TextStyleEnum.headlineMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.headlineSmall(
    this.text, {
    this.xStyle = TextStyleEnum.headlineSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.titleLarge(
    this.text, {
    this.xStyle = TextStyleEnum.titleLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.titleMedium(
    this.text, {
    this.xStyle = TextStyleEnum.titleMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.titleSmall(
    this.text, {
    this.xStyle = TextStyleEnum.titleSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.bodyLarge(
    this.text, {
    this.xStyle = TextStyleEnum.bodyLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.bodyMedium(
    this.text, {
    this.xStyle = TextStyleEnum.bodyMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.bodySmall(
    this.text, {
    this.xStyle = TextStyleEnum.bodySmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.labelLarge(
    this.text, {
    this.xStyle = TextStyleEnum.labelLarge,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.labelMedium(
    this.text, {
    this.xStyle = TextStyleEnum.labelMedium,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.labelSmall(
    this.text, {
    this.xStyle = TextStyleEnum.labelSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  const XText.customStyle(
    this.text, {
    this.xStyle = TextStyleEnum.labelSmall,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
    this.xKey,
  }) : super(key: xKey);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      key: xKey,
      style: style ?? _getTextStyle(context),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }

  TextStyle? _getTextStyle(BuildContext context) {
    switch (xStyle) {
      case TextStyleEnum.displayLarge:
        return context.displayLarge;
      case TextStyleEnum.displayMedium:
        return context.displayMedium;
      case TextStyleEnum.displaySmall:
        return context.displaySmall;
      case TextStyleEnum.headlineLarge:
        return context.headlineLarge;
      case TextStyleEnum.headlineMedium:
        return context.headlineMedium;
      case TextStyleEnum.headlineSmall:
        return context.headlineSmall;
      case TextStyleEnum.titleLarge:
        return context.titleLarge;
      case TextStyleEnum.titleMedium:
        return context.titleMedium;
      case TextStyleEnum.titleSmall:
        return context.titleSmall;
      case TextStyleEnum.bodyLarge:
        return context.bodyLarge;
      case TextStyleEnum.bodyMedium:
        return context.bodyMedium;
      case TextStyleEnum.bodySmall:
        return context.bodySmall;
      case TextStyleEnum.labelLarge:
        return context.labelLarge;
      case TextStyleEnum.labelMedium:
        return context.labelMedium;
      case TextStyleEnum.labelSmall:
        return context.labelSmall;
      default:
        return context.bodyMedium;
    }
  }
}
