class UserModel {
  final int id;
  final String email;
  final bool isEnabled;
  final String phone;
  final String fullName;
  final String username;
  final String birthday;
  final List<String> roles;

  UserModel({
    required this.id,
    required this.email,
    required this.isEnabled,
    required this.phone,
    required this.fullName,
    required this.username,
    required this.birthday,
    required this.roles,
  });
}
