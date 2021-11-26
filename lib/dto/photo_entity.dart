import 'image_entity.dart';

/// id : 84
/// name : "1"
/// dateCreate : "-0001-11-30T00:00:00+02:31"
/// description : "1"
/// isNew : true
/// isPopular : false
/// image : {"id":229,"name":"5badea780fd2c987088603.jpg"}
/// user : null

class PhotoEntity {
  final int id;
  final ImageEntity image;
  final bool? isNew;
  final bool? isPopular;
  final String? name;
  final String? dateCreate;
  final String? description;

  PhotoEntity({
    required this.id,
    required this.image,
    this.isNew,
    this.isPopular,
    this.name,
    this.dateCreate,
    this.description,
  });

  factory PhotoEntity.fromJson(dynamic json) => PhotoEntity(
        id: json['id'],
        name: json['name'],
        dateCreate: json['dateCreate'],
        description: json['description'],
        isNew: json['new'],
        isPopular: json['popular'],
        image: ImageEntity.fromJson(json['image']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'dateCreate': dateCreate,
        'description': description,
        'new': isNew,
        'popular': isPopular,
        'image': image.toJson(),
      };
}
