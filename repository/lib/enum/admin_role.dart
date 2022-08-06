enum AdminRole { superAdmin, admin, employee }

AdminRole? adminRoleFromKey({required String key}) {
  switch (key) {
    case 'SUPER_ADMIN':
      return AdminRole.superAdmin;

    case 'ADMIN':
      return AdminRole.admin;

    case 'EMPLOYEE':
      return AdminRole.employee;

    default:
      return null;
  }
}

extension AdminRoleExtension on AdminRole {
  String get value {
    switch (this) {
      case AdminRole.superAdmin:
        return 'SUPER_ADMIN';

      case AdminRole.admin:
        return 'ADMIN';

      case AdminRole.employee:
        return 'EMPLOYEE';
    }
  }
}
