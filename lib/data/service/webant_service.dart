import 'package:dio/dio.dart';
import 'package:gallery/constants.dart';
import 'package:gallery/data/api/model/base_api.dart';
import 'package:gallery/data/api/request/get_photos_body.dart';

class WebantService {
  final Dio dio = Dio(BaseOptions(baseUrl: Constants.apiBaseUrl));

  Future<BaseApi> getPhotos(GetPhotosBody getPhotosBody) async {
    Response response = await dio.get(
      '/api',
      queryParameters: getPhotosBody.toApi(),
    );
    if (response.statusCode == 200) {
      return BaseApi.fromApi(response.data);
    } else {
      throw Exception('Error getting photos');
    }
  }
}
