class ClientModel {
  final int id;
  final String name;
  final String randomId;
  final String secret;
  final List<String> allowedGrantTypes;

  ClientModel({
    required this.id,
    required this.name,
    required this.randomId,
    required this.secret,
    required this.allowedGrantTypes,
  });
}
