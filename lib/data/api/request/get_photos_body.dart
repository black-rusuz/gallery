class GetPhotosBody {
  final bool isNew;
  final bool isPopular;
  final int page;
  final int limit;

  GetPhotosBody({
    required this.isNew,
    required this.isPopular,
    required this.page,
    required this.limit,
  });

  Map<String, dynamic> toApi() {
    Map<String, dynamic> query = {'page': page, 'limit': limit};
    if (isNew) query.addAll({'new': isNew});
    if (isPopular) query.addAll({'popular': isPopular});
    return query;
  }
}
