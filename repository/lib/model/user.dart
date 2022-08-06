import 'package:repository/model/model.dart';
import 'package:repository/enum/enum.dart';

class User extends Entity {
  final String id;
  final String name;
  final String email;
  final AdminRole role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // ignore: prefer_constructors_over_static_methods
  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'] ?? 'No Name',
      email: json['email'],
      role: adminRoleFromKey(key: json['role']) ?? AdminRole.admin,
    );
  }

  @override
  List<Object> get props => [id];
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role.value
    };
  }
}
