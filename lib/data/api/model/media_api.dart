class MediaApi {
  final String file;
  final String name;
  final int id;

  MediaApi({
    required this.file,
    required this.name,
    required this.id,
  });

  factory MediaApi.fromJson(dynamic json) => MediaApi(
        file: json['file'],
        name: json['name'],
        id: json['id'],
      );
}
