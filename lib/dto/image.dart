/// id : 229
/// name : "5badea780fd2c987088603.jpg"

class Image {
  final int id;
  final String name;

  Image({required this.id, required this.name});

  factory Image.fromJson(dynamic json) =>
      Image(id: json['id'], name: json['name']);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
