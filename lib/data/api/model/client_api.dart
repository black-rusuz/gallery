class ClientApi {
  final int id;
  final String name;
  final String randomId;
  final String secret;
  final List<String> allowedGrantTypes;

  ClientApi({
    required this.id,
    required this.name,
    required this.randomId,
    required this.secret,
    required this.allowedGrantTypes,
  });

  factory ClientApi.fromJson(dynamic json) => ClientApi(
        id: json['id'],
        name: json['name'],
        randomId: json['randomId'],
        secret: json['secret'],
        allowedGrantTypes: json['allowedGrantTypes'] as List<String>,
      );
}
