part of 'breadcrumb_view.dart';

class BreadcrumbItem extends StatefulWidget {
  final bool isLast;
  final BreadcrumbPage breadcrumb;
  final TextStyle normalStyle;
  final TextStyle highlightStyle;
  final TextStyle selectedStyle;
  final void Function(BreadcrumbPage) onPageSelected;

  const BreadcrumbItem({
    super.key,
    required this.isLast,
    required this.breadcrumb,
    required this.normalStyle,
    required this.highlightStyle,
    required this.selectedStyle,
    required this.onPageSelected,
  });

  @override
  State<BreadcrumbItem> createState() => _BreadcrumbItem();
}

class _BreadcrumbItem extends State<BreadcrumbItem> {
  final _hovered = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _hovered.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              if (!widget.isLast) {
                widget.onPageSelected(widget.breadcrumb);
              }
            },
            child: MouseRegion(
              onEnter: (_) => _hovered.value = true,
              onExit: (_) => _hovered.value = false,
              cursor: widget.isLast
                  ? SystemMouseCursors.contextMenu
                  : SystemMouseCursors.click,
              child: AnimatedBuilder(
                animation: _hovered,
                builder: (_, __) {
                  return XText.displaySmall(
                    widget.breadcrumb.title,
                    style: widget.isLast
                        ? widget.selectedStyle
                        : _hovered.value
                            ? widget.highlightStyle
                            : widget.normalStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
          ),
        ),
        if (!widget.isLast)
          XText.displaySmall(' / ', style: widget.selectedStyle)
      ],
    );
  }
}
