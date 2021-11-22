import 'image.dart';

/// id : 84
/// name : "1"
/// dateCreate : "-0001-11-30T00:00:00+02:31"
/// description : "1"
/// isNew : true
/// isPopular : false
/// image : {"id":229,"name":"5badea780fd2c987088603.jpg"}
/// user : null

class Photo {
  final int id;
  final String name;
  final String dateCreate;
  final String description;
  final bool isNew;
  final bool isPopular;
  final Image image;
  final dynamic user;

  Photo({
    required this.id,
    required this.name,
    required this.dateCreate,
    required this.description,
    required this.isNew,
    required this.isPopular,
    required this.image,
    required this.user
  });

  factory Photo.fromJson(dynamic json) => Photo(
    id: json['id'],
    name: json['name'],
    dateCreate: json['dateCreate'],
    description: json['description'],
    isNew: json['new'],
    isPopular: json['popular'],
    image: Image.fromJson(json['image']),
    user: json['user'],
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['dateCreate'] = dateCreate;
    map['description'] = description;
    map['new'] = isNew;
    map['popular'] = isPopular;
    map['image'] = image.toJson();
    map['user'] = user;
    return map;
  }

}