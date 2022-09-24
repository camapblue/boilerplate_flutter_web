import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/widgets/widgets.dart';
import 'package:flutter/material.dart';

class XPasswordTextFormField extends StatefulWidget {
  final String? labelText;
  final String? errorMessage;
  final Widget? errorIcon;
  final String? hintText;
  final bool? obsureText;
  final bool showForgotPwd;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final String? forgotPasswordTitle;
  final GestureTapCallback? onForgotPassword;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final double? errorContainerHeight;
  final TextStyle? errorTextStyle;
  final AutovalidateMode? autoValidateMode;

  const XPasswordTextFormField({
    Key? key,
    this.controller,
    this.obsureText,
    this.validator,
    this.labelText,
    this.errorMessage,
    this.errorIcon,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.onSaved,
    this.forgotPasswordTitle,
    this.onForgotPassword,
    this.showForgotPwd = false,
    this.focusNode,
    this.errorContainerHeight,
    this.errorTextStyle,
    this.autoValidateMode,
  }) : super(key: key);

  @override
  State<XPasswordTextFormField> createState() => _XPasswordTextFormFieldState();
}

class _XPasswordTextFormFieldState extends State<XPasswordTextFormField> {
  late final ValueNotifier<bool> _obsureTextValueChangeNotifier;

  @override
  void initState() {
    super.initState();
    _obsureTextValueChangeNotifier = ValueNotifier(widget.obsureText ?? true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _obsureTextValueChangeNotifier,
      builder: (_, __) {
        return XTextFormField(
          focusNode: widget.focusNode,
          customLabel: widget.showForgotPwd
              ? Row(
                  children: [
                    Expanded(child: XText.titleSmall(widget.labelText)),
                    InkWell(
                      onTap: widget.onForgotPassword,
                      child: XText.titleSmall(
                        widget.forgotPasswordTitle ?? 'Forgot Password',
                        style: context.titleSmall!
                            .copyWith(color: context.primaryColor),
                      ),
                    ),
                  ],
                )
              : null,
          controller: widget.controller,
          labelText: widget.labelText,
          hintText: widget.hintText,
          validator: widget.validator,
          isEditMode: true,
          obsureText: _obsureTextValueChangeNotifier.value,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          onSaved: widget.onSaved,
          errorIcon: widget.errorIcon,
          prefixWidget: const Icon(
            Icons.lock,
            size: 15,
          ),
          suffixWidget: InkWell(
            child: Icon(
              _obsureTextValueChangeNotifier.value
                  ? Icons.visibility
                  : Icons.visibility_off,
              size: 15,
              color: context.primaryColor,
            ),
            onTap: () {
              final value = _obsureTextValueChangeNotifier.value;
              _obsureTextValueChangeNotifier.value = !value;
            },
          ),
          errorContainerHeight: widget.errorContainerHeight,
          errorTextStyle: widget.errorTextStyle,
          autoValidateMode: widget.autoValidateMode,
        );
      },
    );
  }

  @override
  void dispose() {
    _obsureTextValueChangeNotifier.dispose();
    super.dispose();
  }
}
