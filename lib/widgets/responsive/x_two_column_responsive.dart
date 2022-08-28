part of 'responsive_template_widget.dart';

class XTwoColumnResponsive extends StatelessWidget {
  final Widget headerLayout;
  final Widget contentLayout;

  const XTwoColumnResponsive({
    Key? key,
    required this.headerLayout,
    required this.contentLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
        Container(
          width: 491,
          alignment: Alignment.centerRight,
          child: headerLayout,
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Container(
          width: 491,
          alignment: Alignment.centerLeft,
          child: contentLayout,
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }
}
