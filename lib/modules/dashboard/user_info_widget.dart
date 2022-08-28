part of 'dashboard_view.dart';

class UserInfoWidget extends StatelessWidget {
  final String? avatarUrl;
  final String? userName;
  final String? department;

  const UserInfoWidget({
    Key? key,
    this.avatarUrl,
    this.userName,
    this.department,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            border: Border.all(width: 1.5, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: XImageNetwork(
            imagePath:
                'https://vienthammydiva.vn/wp-content/uploads/2022/05/avatar-dep-ngau-nu13-e1653039495652.jpg',
            width: 100.0,
            height: 100.0,
            borderRadius: BorderRadius.circular(100.0),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 14.0),
        XText.titleLarge(
          userName ?? 'Florence MARTIN',
          style: context.titleLarge?.copyWith(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2.0),
        XText(
          department ?? 'HR representative',
          style: context.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
