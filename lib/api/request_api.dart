import 'package:dio/dio.dart';
import 'package:pictures/constants.dart';
import 'package:pictures/dto/photo.dart';
import 'package:pictures/dto/response_data.dart';

import 'request_interface.dart';

class RequestApi implements RequestInterface {
  @override
  Future<ResponseData<Photo>> getPhotos({
    bool isNew = false,
    bool isPopular = false,
    int page = 1,
    int limit = 14,
  }) async {
    Dio dio = Dio();
    Map<String, dynamic> parameters = {'page': page, 'limit': limit};
    if (isNew) parameters.addAll({'new': isNew});
    if (isPopular) parameters.addAll({'popular': isPopular});
    Response response =
        await dio.get(Constants.apiRequestUrl, queryParameters: parameters);
    if (response.statusCode == 200) {
      ResponseData<Photo> responseData = ResponseData.fromJson(response.data);
      return responseData;
    } else {
      throw Exception('Error fetching posts');
    }
  }

  @override
  Future<List<Photo>> getPhotosList(
      {bool isNew = false,
      bool isPopular = false,
      int page = 1,
      int limit = 14}) async {
    Dio dio = Dio();
    Map<String, dynamic> parameters = {'page': page, 'limit': limit};
    if (isNew) parameters.addAll({'new': isNew});
    if (isPopular) parameters.addAll({'popular': isPopular});
    Response response =
        await dio.get(Constants.apiRequestUrl, queryParameters: parameters);
    if (response.statusCode == 200) {
      List list = response.data['data'];
      List<Photo> photos = list.map((e) => Photo.fromJson(e)).toList();
      return photos;
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
