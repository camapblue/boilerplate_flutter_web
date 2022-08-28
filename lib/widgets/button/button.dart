import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_flutter_web/constants/constants.dart';
import 'package:boilerplate_flutter_web/theme/theme.dart';

export 'ink_well_button.dart';

class Button extends StatelessWidget {
  final String title;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Color titleColor;
  final VoidCallback? onPressed;
  final bool loading;
  final double height;
  final double? width;
  final double? titleFontSize;
  final EdgeInsets? padding;
  final Brightness indicatorBrightness;

  const Button({
    Key? key,
    required this.title,
    this.borderRadius,
    this.backgroundColor,
    this.border,
    this.titleColor = Colors.white,
    this.onPressed,
    this.loading = false,
    this.height = 50,
    this.width,
    this.titleFontSize = 16,
    this.padding,
    this.indicatorBrightness = Brightness.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loading ? null : onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          border: border,
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: loading
              ? Theme(
                  data: ThemeData(
                    cupertinoOverrideTheme: CupertinoThemeData(
                      brightness: indicatorBrightness,
                    ),
                  ),
                  child: const CupertinoActivityIndicator())
              : Text(
                  title,
                  style: Theme.of(context).primaryButton.copyWith(
                        color: titleColor,
                        fontSize: titleFontSize,
                      ),
                ),
        ),
      ),
    );
  }

  factory Button.pink({
    required String title,
    bool loading = false,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    double? titleFontSize,
    BorderRadius? borderRadius,
  }) {
    if (onPressed == null) {
      return Button._disabled(
        title: title,
        loading: loading,
      );
    }

    return Button(
      backgroundColor: AppColors.pink,
      title: title,
      borderRadius: borderRadius ?? BorderRadius.circular(8),
      onPressed: onPressed,
      loading: loading,
      indicatorBrightness: Brightness.dark,
      padding: padding,
      titleFontSize: titleFontSize,
    );
  }

  factory Button._disabled({
    required String title,
    final bool loading = false,
    final double titleFontSize = 16,
  }) {
    return Button(
      backgroundColor: AppColors.disabled,
      title: title,
      borderRadius: BorderRadius.circular(8),
      loading: loading,
      titleFontSize: titleFontSize,
    );
  }

  factory Button.outlinedBlue({
    required String title,
    VoidCallback? onPressed,
    final bool loading = false,
  }) {
    if (onPressed == null) {
      return Button._disabled(
        title: title,
        loading: loading,
      );
    }

    return Button(
      backgroundColor: Colors.white,
      title: title,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: AppColors.accentOri, width: 1.6),
      titleColor: AppColors.accentOri,
      onPressed: onPressed,
      loading: loading,
    );
  }

  factory Button.outlinedPink({
    Key? key,
    required String title,
    VoidCallback? onPressed,
    bool loading = false,
    double titleFontSize = 16,
  }) {
    if (onPressed == null) {
      return Button._disabled(
        title: title,
        titleFontSize: titleFontSize,
        loading: loading,
      );
    }

    return Button(
      key: key,
      backgroundColor: Colors.transparent,
      title: title,
      borderRadius: BorderRadius.circular(8),
      titleColor: AppColors.pink,
      titleFontSize: titleFontSize,
      onPressed: onPressed,
      loading: loading,
    );
  }

  factory Button.reload({
    required BuildContext context,
    bool loading = false,
    VoidCallback? onPressed,
  }) {
    return Button(
      backgroundColor: AppColors.pink,
      title: 'Reload',
      borderRadius: BorderRadius.circular(8),
      height: 32,
      width: 96,
      onPressed: onPressed,
      loading: loading,
    );
  }
}
