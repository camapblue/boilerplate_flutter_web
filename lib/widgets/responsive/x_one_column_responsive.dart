part of 'responsive_template_widget.dart';

class XOneColumnResponsive extends StatelessWidget {
  final Widget headerLayout;
  final Widget contentLayout;

  const XOneColumnResponsive({
    Key? key,
    required this.headerLayout,
    required this.contentLayout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 152),
          headerLayout,
          const SizedBox(height: 56),
          contentLayout,
        ],
      ),
    );
  }
}
