import 'dart:convert';
import 'dart:async';

import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:http/http.dart' as http;
import 'package:pictures/dto/photo.dart';
import 'package:pictures/constants.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final http.Client httpClient;
  final bool isNew;
  final bool isPopular;

  int _page = 1;
  int _pageCount = 1;
  List<Photo> _photos = [];

  PhotoBloc(
      {required this.httpClient, this.isNew = false, this.isPopular = false})
      : super(PhotoInitial()) {
    on<PhotoFetched>(_onPhotoFetched);
  }

  Future<void> _onPhotoFetched(
    PhotoFetched event, Emitter<PhotoState> emit) async {
    if (_page <= _pageCount) {
      try {
        final List<Photo> photos = await _fetchPhotos(_page);
        _photos.addAll(photos);
        if (photos.isEmpty) {
          emit(PhotoEmptyList());
        } else {
          _page++;
          emit(PhotoSuccess(photos: _photos));
        }
      } catch (_) {
        emit(PhotoError());
      }
    }
  }

  Future<List<Photo>> _fetchPhotos(int startPage) async {
    String requestUrl = Constants.apiRequest + '?';
    if (isNew) {
      requestUrl += 'new=' + isNew.toString() + '&'; }
    if (isPopular) {
      requestUrl += 'popular=' + isPopular.toString() + '&'; }
    requestUrl += 'page=' + startPage.toString() + '&' + 'limit=14&';

    final http.Response response =
        await http.get(Uri.parse(requestUrl.toLowerCase()));
    if (response.statusCode == 200) {
      _pageCount = jsonDecode(response.body)['countOfPages'];
      Iterable i = jsonDecode(response.body)['data'];
      return List<Photo>.from(i.map((model) => Photo.fromJson(model)));
    } else {
      throw Exception('Error fetching posts');
    }
  }
}
