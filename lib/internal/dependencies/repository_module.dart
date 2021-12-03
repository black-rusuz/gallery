import 'package:gallery/data/repository/base_data_repository.dart';
import 'package:gallery/domain/repository/base_repository.dart';
import 'package:gallery/internal/dependencies/api_module.dart';

class RepositoryModule {
  static final BaseRepository _baseRepository =
      BaseDataRepository(ApiModule.apiUtil());

  static BaseRepository apiUtil() {
    return _baseRepository;
  }
}
