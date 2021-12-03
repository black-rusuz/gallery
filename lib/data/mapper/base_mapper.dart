import '/domain/model/base_model.dart';
import '../api/model/base_api.dart';
import '../api/model/client_api.dart';
import '../api/model/media_api.dart';
import '../api/model/photo_api.dart';
import '../api/model/user_api.dart';

class BaseMapper<T> {
  static BaseModel fromApi(BaseApi baseApi) {
    return BaseModel(
      totalItems: baseApi.totalItems,
      itemsPerPage: baseApi.itemsPerPage,
      countOfPages: baseApi.countOfPages,
      data: _castData(baseApi.data),
    );
  }

  static List<T> _castData<T>(List<Map<String, dynamic>> list) {
    if (T is PhotoApi) {
      return list.map((e) => PhotoApi.fromJson(e) as T).toList();
    }
    else {
      return list.map((e) => e as T).toList();
    }
  }
}