/// id : 229
/// name : "5badea780fd2c987088603.jpg"

class ImageEntity {
  final int id;
  final String name;

  ImageEntity({required this.id, required this.name});

  factory ImageEntity.fromJson(dynamic json) =>
      ImageEntity(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
