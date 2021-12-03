class UserApi {
  final int id;
  final String email;
  final bool isEnabled;
  final String phone;
  final String fullName;
  final String username;
  final String birthday;
  final List<String> roles;

  UserApi({
    required this.id,
    required this.email,
    required this.isEnabled,
    required this.phone,
    required this.fullName,
    required this.username,
    required this.birthday,
    required this.roles,
  });

  factory UserApi.fromJson(dynamic json) => UserApi(
        id: json['id'],
        email: json['email'],
        isEnabled: json['enabled'],
        phone: json['phone'],
        fullName: json['fullName'],
        username: json['username'],
        birthday: json['birthday'],
        roles: json['roles'] as List<String>,
      );
}
