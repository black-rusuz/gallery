import 'package:pictures/dto/photo_entity.dart';
import 'package:pictures/dto/response_data.dart';

abstract class RequestInterface {
  Future<ResponseData<PhotoEntity>> getPhotos(
      {bool isNew, bool isPopular, int page, int limit});
}
