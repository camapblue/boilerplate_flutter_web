import 'package:flutter/services.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final String? title;
  final String? placeholder;
  final void Function(String? value)? onFieldSubmitted;
  final void Function(String? value)? onValid;
  final TextStyle? titleStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final EdgeInsets? padding;
  final InputValidatorRule? passwordRule;
  final TextEditingController? textController;
  final String? errorMessage;
  final bool autocorrect;
  final bool enabled;
  final bool submitOnChange;
  final bool passwordRequired;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const PasswordInput({
    super.key,
    this.title = '',
    this.placeholder = '',
    this.titleStyle,
    this.hintStyle,
    this.textStyle,
    this.errorTextStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.focusNode,
    this.textInputAction,
    this.padding,
    this.passwordRule,
    this.onValid,
    this.onFieldSubmitted,
    this.textController,
    this.errorMessage,
    this.autocorrect = true,
    this.enabled = true,
    this.submitOnChange = false,
    this.passwordRequired = true,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  late TextEditingController _controller;
  var _errorMessage = '';
  var _isVisibility = false;
  late final FocusNode _focusNode;
  final _validatorRules = <InputValidatorRule>[];

  @override
  void initState() {
    super.initState();

    if (widget.passwordRequired) {
      _validatorRules.add(
        InputValidatorRule.require(errorMessage: 'Password is required'),
      );
    }

    _controller = widget.textController ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onChangeFocus);

    if (widget.passwordRule != null) {
      _validatorRules.add(widget.passwordRule!);
    }
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

    setState(() {});
  }

  void _onChanged(String value, {bool submit = false}) {
    if (_errorMessage.isNotEmpty || submit) {
      if (_validatorRules.isNotEmpty) {
        _errorMessage = _validatorRules.validate(value);

        setState(() {});
      }
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
  void didUpdateWidget(covariant PasswordInput oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.errorMessage != widget.errorMessage) {
      _errorMessage = widget.errorMessage ?? '';
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
          decoration: InputDecoration(
            counterText: '',
            hintText: widget.placeholder,
            hintStyle: widget.hintStyle ??
                context.bodySmall?.copyWith(
                  color: AppColors.lightGray,
                ),
            filled: !widget.enabled ||
                _errorMessage.isNotEmpty && !_focusNode.hasFocus,
            fillColor: widget.enabled
                ? _errorMessage.isEmpty
                    ? null
                    : context.errorColor.withOpacity(0.1)
                : context.disabledBackgroundColor.withOpacity(0.6),
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
                  top: 10,
                  bottom: 14,
                ),
            isCollapsed: true,
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Icon(
                Icons.lock_outline,
                size: 20,
                color: AppColors.dark,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisibility = !_isVisibility;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  _isVisibility
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.dark,
                  size: 20,
                ),
              ),
            ),
          ),
          style: widget.textStyle ?? context.bodyMedium,
          inputFormatters: widget.inputFormatters,
          keyboardType: TextInputType.text,
          textInputAction: widget.textInputAction,
          maxLength: widget.maxLength,
          onChanged: (value) =>
              _onChanged(value, submit: widget.submitOnChange),
          onFieldSubmitted: (value) => _onChanged(value, submit: true),
          autocorrect: widget.autocorrect,
          enabled: widget.enabled,
          obscureText: !_isVisibility,
        ),
        const SizedBox(
          height: 2,
        ),
        _buildErrorMessage(),
      ],
    );
  }
}
