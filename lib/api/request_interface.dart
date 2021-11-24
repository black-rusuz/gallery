import 'package:pictures/dto/photo.dart';

abstract class RequestInterface {
  Future<List<Photo>> getPhotos(
      {bool isNew, bool isPopular, int page});
}
