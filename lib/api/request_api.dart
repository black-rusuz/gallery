import 'package:dio/dio.dart';
import 'package:gallery/constants.dart';
import 'package:gallery/dto/photo_entity.dart';
import 'package:gallery/dto/response_data.dart';

import 'request_interface.dart';

class RequestApi implements RequestInterface {
  @override
  Future<ResponseData<PhotoEntity>> getPhotos({
    required bool isNew,
    required bool isPopular,
    required int page,
    required int limit,
  }) async {
    Dio dio = Dio();
    Map<String, dynamic> parameters = {'page': page, 'limit': limit};
    if (isNew) parameters.addAll({'new': isNew});
    if (isPopular) parameters.addAll({'popular': isPopular});
    Response response =
        await dio.get(Constants.apiRequestUrl, queryParameters: parameters);
    if (response.statusCode == 200) {
      ResponseData<PhotoEntity> responseData = ResponseData<PhotoEntity>.fromJson(response.data);
      return responseData;
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
