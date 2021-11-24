import 'package:dio/dio.dart';
import 'package:pictures/constants.dart';
import 'package:pictures/dto/photo.dart';

import 'request_interface.dart';

class RequestApi implements RequestInterface {
  final int limit;

  RequestApi({this.limit = 14});

  @override
  Future<List<Photo>> getPhotos(
      {bool isNew = false, bool isPopular = false, int page = 1}) async {
    print(page);
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
