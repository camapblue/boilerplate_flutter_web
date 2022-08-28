part of 'dashboard_view.dart';

class MenuItemWidget extends StatelessWidget {
  final String? title;
  final Widget? icon;
  final GestureTapCallback? onTap;
  final bool? isFirst;
  final bool isSelected;
  final bool isParent;

  const MenuItemWidget({
    Key? key,
    this.title,
    this.isFirst = false,
    this.icon,
    this.onTap,
    this.isSelected = false,
    this.isParent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black12 : Colors.transparent,
          border: Border(
            top: (isFirst ?? false)
                ? BorderSide(color: Colors.white.withOpacity(.1))
                : BorderSide.none,
            bottom: BorderSide(color: Colors.white.withOpacity(.1)),
            left: BorderSide(
              color: isSelected && isParent ? Colors.white : Colors.transparent,
              width: 5.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon ?? const Icon(
              Icons.dashboard,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: XText(
                title ?? '',
                style: context.bodyMedium?.copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
