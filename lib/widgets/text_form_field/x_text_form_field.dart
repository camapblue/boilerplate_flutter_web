import 'dart:math';

import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'z_text_form_field.dart';

class XTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final Widget? customLabel;
  final String? initializationText;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool autoFocus;
  final bool isEditMode;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextCapitalization textCapitalization;
  final double radius;
  final InputDecoration? inputDecoration;
  final bool obsureText;
  final TextAlign textAlign;
  final TextStyle? style;
  final Color? backgroundColor;
  final bool isCenterLabel;
  final FormFieldValidator<String>? validator;
  final String? restorationId;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final Widget? errorIcon;
  final double? errorContainerHeight;
  final TextStyle? errorTextStyle;
  final AutovalidateMode? autoValidateMode;
  final EdgeInsets? padding;
  final double prefixIconHeight;
  final double suffixIconHeight;

  const XTextFormField({
    Key? key,
    this.isEditMode = true,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.inputFormatters,
    this.labelText,
    this.customLabel,
    this.initializationText,
    this.prefixWidget,
    this.suffixWidget,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.keyboardType,
    this.autoFocus = true,
    this.textInputAction,
    this.focusNode,
    this.textCapitalization = TextCapitalization.none,
    this.radius = 8.0,
    this.inputDecoration,
    this.obsureText = false,
    this.textAlign = TextAlign.start,
    this.style,
    this.backgroundColor = Colors.white,
    this.isCenterLabel = false,
    this.validator,
    this.restorationId,
    this.onFieldSubmitted,
    this.onSaved,
    this.errorIcon,
    this.errorContainerHeight,
    this.errorTextStyle,
    this.autoValidateMode,
    this.padding,
    this.prefixIconHeight = double.infinity,
    this.suffixIconHeight = double.infinity,
  }) : super(key: key);

  @override
  XTextFormFieldState createState() => XTextFormFieldState();
}

class XTextFormFieldState extends State<XTextFormField> {
  @override
  Widget build(BuildContext context) {
    return ZTextFormField(
      customLabel: widget.customLabel,
      labelText: widget.labelText,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      maxLines: max(widget.minLines, widget.maxLines),
      maxLength: widget.maxLength,
      enabled: widget.isEditMode,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      textAlignVertical: TextAlignVertical.center,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      textCapitalization: widget.textCapitalization,
      decoration: _buildInputDecoration(context),
      obscureText: widget.obsureText,
      textAlign: widget.textAlign,
      style: widget.style,
      minLines: widget.minLines,
      validator: widget.validator,
      restorationId: widget.restorationId,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      errorIcon: widget.errorIcon,
      initialValue: widget.initializationText,
      errorContainerHeight: widget.errorContainerHeight,
      errorTextStyle: widget.errorTextStyle,
      autoValidateMode: widget.autoValidateMode ?? AutovalidateMode.disabled,
    );
  }

  InputDecoration _buildInputDecoration(BuildContext context) {
    return InputDecoration(
      isDense: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: BorderSide(color: context.borderColor, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: BorderSide(color: context.primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: BorderSide(color: context.borderColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: BorderSide(color: context.errorColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(widget.radius),
        borderSide: BorderSide(color: context.borderColor),
      ),
      counterText: '',
      alignLabelWithHint: true,
      contentPadding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      filled: true,
      hintText: widget.hintText,
      hintStyle: context.labelSmall?.copyWith(color: context.disabledColor),
      errorMaxLines: 1,
      errorStyle: const TextStyle(
        fontSize: 0.01,
        height: 0.01,
        color: Colors.transparent,
      ),
      fillColor: widget.isEditMode
          ? widget.backgroundColor ?? context.cardColor
          : context.disabledColor,
      prefixIcon: widget.prefixWidget != null
          ? Container(
              margin: const EdgeInsets.only(left: 15, right: 5),
              child: widget.prefixWidget,
            )
          : null,
      suffixIcon: widget.suffixWidget != null
          ? Container(
              margin: const EdgeInsets.only(right: 15, left: 5),
              child: widget.suffixWidget,
            )
          : null,
      prefixIconConstraints: BoxConstraints(
        maxHeight: widget.prefixIconHeight,
      ),
      suffixIconConstraints: BoxConstraints(
        maxHeight: widget.suffixIconHeight,
      ),
    );
  }
}
