import 'package:gallery/data/api/request/get_photos_body.dart';
import 'package:gallery/data/mapper/base_mapper.dart';
import 'package:gallery/data/service/webant_service.dart';
import 'package:gallery/domain/model/base_model.dart';

class ApiUtil {
  final WebantService _webantService;

  ApiUtil(this._webantService);

  Future<BaseModel> getPhoto({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  }) async {
    final GetPhotosBody body = GetPhotosBody(
      isNew: isNew,
      isPopular: isPopular,
      page: page,
      limit: limit,
    );
    final result = await _webantService.getPhotos(body);
    return BaseMapper.fromApi(result);
  }
}
