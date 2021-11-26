import 'Photo.dart';

/// totalItems : 680
/// itemsPerPage : 2
/// countOfPages : 340
/// data : [
/// {"id":84,"name":"1","dateCreate":"-0001-11-30T00:00:00+02:31","description":"1","new":true,"popular":false,"image":{"id":229,"name":"5badea780fd2c987088603.jpg"},"user":null},
/// {"id":93,"name":"qqq","dateCreate":"-0001-11-30T00:00:00+02:31","description":"qqqq","new":false,"popular":true,"image":{"id":243,"name":"5bb3466053cf3277626807.jpg"},"user":null}
/// ]

class ResponseData<T> {
  late final int totalItems;
  late final int itemsPerPage;
  late final int countOfPages;
  late final List<T> data;

  ResponseData({
    required this.totalItems,
    required this.itemsPerPage,
    required this.countOfPages,
    required this.data,
  });

  ResponseData.fromJson(dynamic json) {
    totalItems = json['totalItems'];
    itemsPerPage = json['itemsPerPage'];
    countOfPages = json['countOfPages'];
    data = List<T>.from(json['data'].map((x) => Photo.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['totalItems'] = totalItems;
    map['itemsPerPage'] = itemsPerPage;
    map['countOfPages'] = countOfPages;

    if (T is Photo) {
      map['data'] = List<T>.from(data.map((x) => (x as Photo).toJson()));
    }

    return map;
  }
}
