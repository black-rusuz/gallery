import 'media_model.dart';

class PhotoModel {
  final int id;
  final String name;
  final String dateCreate;
  final String description;
  final bool isNew;
  final bool isPopular;
  final MediaModel image;
  final String user;

  PhotoModel({
    required this.id,
    required this.name,
    required this.dateCreate,
    required this.description,
    required this.isNew,
    required this.isPopular,
    required this.image,
    required this.user,
  });
}
