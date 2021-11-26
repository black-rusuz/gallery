import 'package:pictures/dto/photo.dart';
import 'package:pictures/dto/response_data.dart';

abstract class RequestInterface {
  Future<ResponseData<Photo>> getPhotos(
      {bool isNew, bool isPopular, int page, int limit});
  Future<List<Photo>> getPhotosList(
      {bool isNew, bool isPopular, int page, int limit});
}
