part of 'user_list_view.dart';

class HeaderItem {
  final String text;
  final int flex;

  const HeaderItem({
    required this.flex,
    required this.text,
  });
}

const _headerCells = <HeaderItem>[
  HeaderItem(flex: 200, text: 'Name'),
  HeaderItem(flex: 300, text: 'Email'),
  HeaderItem(flex: 175, text: 'Role'),
  HeaderItem(flex: 125, text: 'Action'),
];

class UserTableView extends StatelessWidget {
  final List<User> users;
  const UserTableView({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _headerCells
                .map(
                  (e) => Expanded(
                    flex: e.flex,
                    child: TableHeader(
                      showDivider: true,
                      text: context.translate(e.text),
                    ),
                  ),
                )
                .toList(),
          ),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: users
                    .mapIndex(
                      (user, i) => UserRowItem(
                        user: user,
                        isEven: i % 2 != 0,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
