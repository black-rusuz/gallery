class PhotoApi {
  final int id;
  final String name;
  final String dateCreate;
  final String description;
  final bool isNew;
  final bool isPopular;
  final Map<String, dynamic> image;
  final String user;

  PhotoApi({
    required this.id,
    required this.name,
    required this.dateCreate,
    required this.description,
    required this.isNew,
    required this.isPopular,
    required this.image,
    required this.user,
  });

  factory PhotoApi.fromJson(dynamic json) => PhotoApi(
        id: json['id'],
        name: json['name'],
        dateCreate: json['dateCreate'],
        description: json['description'],
        isNew: json['new'],
        isPopular: json['popular'],
        image: json['image'],
        user: json['user'],
      );
}
