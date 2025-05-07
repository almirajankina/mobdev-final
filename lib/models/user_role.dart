// lib/models/user_role.dart
enum UserRole {
  user,
  admin,
}

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.user:
        return 'user';
      case UserRole.admin:
        return 'admin';
      default:
        return 'user';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return UserRole.admin;
      case 'user':
      default:
        return UserRole.user;
    }
  }
}
