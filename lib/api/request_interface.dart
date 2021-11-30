import 'package:pictures/dto/photo_entity.dart';
import 'package:pictures/dto/response_data.dart';

abstract class RequestInterface {
  Future<ResponseData<PhotoEntity>> getPhotos({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  });
}
