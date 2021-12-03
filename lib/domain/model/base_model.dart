class BaseModel<T> {
  final int totalItems;
  final int itemsPerPage;
  final int countOfPages;
  final List<T> data;

  BaseModel({
    required this.totalItems,
    required this.itemsPerPage,
    required this.countOfPages,
    required this.data,
  });
}
