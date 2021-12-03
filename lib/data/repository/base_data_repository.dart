import 'package:gallery/data/api/api_util.dart';
import 'package:gallery/domain/model/base_model.dart';
import 'package:gallery/domain/repository/base_repository.dart';

class BaseDataRepository extends BaseRepository {
  final ApiUtil _apiUtil;

  BaseDataRepository(this._apiUtil);

  @override
  Future<BaseModel> getPhoto({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  }) {
    return _apiUtil.getPhoto(
      isNew: isNew,
      isPopular: isPopular,
      page: page,
      limit: limit,
    );
  }
}
