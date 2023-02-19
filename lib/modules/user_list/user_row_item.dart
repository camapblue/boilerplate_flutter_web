part of 'user_list_view.dart';

class UserRowItem extends StatelessWidget {
  final User user;
  final bool isEven;

  const UserRowItem({
    super.key,
    required this.user,
    required this.isEven,
  });

  Widget _buildCell({
    required BuildContext context,
    Widget? child,
    bool showDivider = true,
    String? text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: showDivider ? 1 : 0,
            color: context.borderColor,
          ),
        ),
      ),
      child: child ??
          Align(
            alignment: Alignment.centerLeft,
            child: XText.bodySmall(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isEven ? context.backgroundSubdued : AppColors.white,
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 200,
              child: _buildCell(
                context: context,
                text: user.name,
              ),
            ),
            Expanded(
              flex: 300,
              child: _buildCell(
                context: context,
                text: user.email,
              ),
            ),
            Expanded(
              flex: 175,
              child: _buildCell(
                context: context,
                text: context.translate(
                  user.role.name,
                ),
              ),
            ),
            Expanded(
              flex: 125,
              child: _buildCell(
                context: context,
                showDivider: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    XButton.outlined(
                      title: 'Details',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      color: AppColors.neutralDark,
                      onPressed: () {
                        AppRouting().goWithHiddenParams(
                          RouteName.UserDetail.fullPath(user.id),
                          params: {
                            'user': user
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
