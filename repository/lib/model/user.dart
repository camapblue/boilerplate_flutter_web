import 'package:repository/model/model.dart';
import 'package:repository/enum/enum.dart';

class User extends Entity {
  final String id;
  final String name;
  final String email;
  final AdminRole role;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  // ignore: prefer_constructors_over_static_methods
  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: adminRoleFromKey(key: json['role'] ?? 'ADMIN'),
    );
  }

  @override
  List<Object> get props => [id, name, email];
  
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
