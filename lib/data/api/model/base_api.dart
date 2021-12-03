class BaseApi<T> {
  final int totalItems;
  final int itemsPerPage;
  final int countOfPages;
  final List<Map<String, dynamic>> data;

  BaseApi({
    required this.totalItems,
    required this.itemsPerPage,
    required this.countOfPages,
    required this.data,
  });

  factory BaseApi.fromApi(dynamic json) => BaseApi<T>(
        totalItems: json['totalItems'],
        itemsPerPage: json['itemsPerPage'],
        countOfPages: json['countOfPages'],
        data: json['data'] as List<Map<String, dynamic>>,
      );
}
