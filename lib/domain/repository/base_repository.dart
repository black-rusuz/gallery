import '/domain/model/base_model.dart';

abstract class BaseRepository<T> {
  Future<BaseModel<T>> getPhoto({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  });
}
