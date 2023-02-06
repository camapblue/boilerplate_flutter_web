part of 'dashboard_view.dart';

class MenuItemWidget extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final GestureTapCallback? onTap;
  final bool? isFirst;
  final bool isSelected;
  final TextStyle? titleStyle;

  const MenuItemWidget({
    Key? key,
    this.title,
    this.isFirst = false,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Material(
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected ? context.primarySubdued : Colors.transparent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  icon ?? const SizedBox(),
                  const SizedBox(width: 10),
                  Expanded(
                    child: XText.headlineSmall(
                      title ?? '',
                      style: titleStyle ??
                          context.headlineSmall?.copyWith(
                            color: isSelected
                                ? context.textColor
                                : context.disabledColor,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
