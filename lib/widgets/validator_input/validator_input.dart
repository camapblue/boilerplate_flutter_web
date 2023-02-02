import 'package:flutter/services.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:common/common.dart';

class ValidatorInput extends StatefulWidget {
  final String? title;
  final String placeholder;
  final String initialValue;
  final TextInputType keyboardType;
  final void Function(String? value)? onFieldSubmitted;
  final void Function(String? value)? onValid;
  final void Function(String value)? onChanged;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixTextStyle;
  final EdgeInsets? padding;
  final List<InputValidatorRule> validatorRules;
  final TextEditingController? textController;
  final String? errorMessage;
  final bool autocorrect;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final int minLines;
  final int maxLines;
  final EdgeInsets? scrollPadding;

  const ValidatorInput({
    super.key,
    this.title = '',
    this.placeholder = '',
    this.initialValue = '',
    this.titleStyle,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.enabledBorder,
    this.disabledBorder,
    this.focusedBorder,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.prefixText,
    this.prefixTextStyle,
    this.padding,
    this.keyboardType = TextInputType.text,
    this.validatorRules = const [],
    this.onValid,
    this.onFieldSubmitted,
    this.onChanged,
    this.textController,
    this.errorMessage,
    this.autocorrect = true,
    this.inputFormatters,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.scrollPadding,
  });

  @override
  State<ValidatorInput> createState() => _ValidatorInputState();
}

class _ValidatorInputState extends State<ValidatorInput> {
  late TextEditingController _controller;
  var _errorMessage = '';
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = widget.textController ??
        TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_onChangeFocus);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode
      ..removeListener(_onChangeFocus)
      ..dispose();

    super.dispose();
  }

  void _onChangeFocus() {
    if (!_focusNode.hasFocus) {
      _onChanged(_controller.text, submit: true);
    }
  }

  void _onClear() {
    _controller.clear();

    _onChanged('');
  }

  void _onChanged(String value, {bool submit = false}) {
    if (_errorMessage.isNotEmpty || submit) {
      _errorMessage = widget.validatorRules.validate(value);

      setState(() {});
    }
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }

    final validData = _errorMessage.isEmpty ? value : null;
    if (widget.onValid != null) {
      widget.onValid!(validData);
    }

    if (submit) {
      if (widget.onFieldSubmitted != null) {
        widget.onFieldSubmitted!(validData);
      }
    }
  }

  Widget _buildErrorMessage() {
    if (_errorMessage.isEmpty) {
      return const SizedBox(
        height: 16,
      );
    }

    final errorMessageWidget = widget.errorTextStyle != null
        ? XText.labelSmall(
            _errorMessage,
            style: widget.errorTextStyle!,
          )
        : XText.labelSmall(
            _errorMessage,
          ).customWith(context, color: context.errorColor, fontSize: 10);

    return Row(
      children: [
        Icon(
          Icons.error_outline,
          color: context.errorColor,
          size: 11,
        ),
        const SizedBox(
          width: 4,
        ),
        errorMessageWidget,
      ],
    );
  }

  @override
  void didUpdateWidget(covariant ValidatorInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.errorMessage != widget.errorMessage &&
            widget.errorMessage.isNotNullOrEmpty() ||
        oldWidget.initialValue != widget.initialValue &&
            widget.initialValue.isNotNullOrEmpty()) {
      _errorMessage = widget.errorMessage ?? '';
      _controller.text = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          XText.headlineSmall(
            widget.title,
            style: widget.titleStyle,
          ),
          const SizedBox(
            height: 8,
          ),
        ],
        TextFormField(
          controller: _controller,
          focusNode: _focusNode,
          scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20),
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: widget.hintStyle ??
                context.bodySmall?.copyWith(
                  color: AppColors.lightGray,
                ),
            prefixText: widget.prefixText,
            prefixStyle: widget.prefixTextStyle ??
                context.bodySmall?.copyWith(
                  color: context.textColor,
                ),
            filled: !widget.enabled ||
                _errorMessage.isNotEmpty && !_focusNode.hasFocus,
            fillColor: widget.enabled
                ? _errorMessage.isEmpty
                    ? null
                    : context.errorColor.withOpacity(0.1)
                : context.disabledBackgroundColor.withOpacity(0.6),
            disabledBorder: widget.disabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorMessage.isEmpty
                        ? context.disabledBackgroundColor.withOpacity(0.6)
                        : context.errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
            enabledBorder: widget.enabledBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: _errorMessage.isEmpty
                        ? context.borderColor
                        : context.errorColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
            focusedBorder: widget.focusedBorder ??
                OutlineInputBorder(
                  borderSide: BorderSide(
                    color: context.primaryColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
            contentPadding: widget.padding ??
                const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 14,
                  bottom: 14,
                ),
            isCollapsed: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: _focusNode.hasFocus && _controller.text.isNotEmpty
                ? GestureDetector(
                    onTap: _onClear,
                    child: const Icon(
                      Icons.close_outlined,
                      size: 20,
                      color: AppColors.dark,
                    ),
                  )
                : const SizedBox(height: 20),
          ),
          inputFormatters: widget.inputFormatters,
          style: widget.textStyle ??
              context.bodyMedium?.copyWith(
                color: widget.enabled
                    ? context.textColor
                    : context.textColor?.withOpacity(0.6),
              ),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          onChanged: _onChanged,
          onFieldSubmitted: (value) => _onChanged(value, submit: true),
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
        ),
        const SizedBox(
          height: 2,
        ),
        if (widget.validatorRules.isNotEmpty) _buildErrorMessage(),
      ],
    );
  }
}
