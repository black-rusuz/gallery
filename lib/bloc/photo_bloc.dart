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

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final http.Client httpClient;
  final bool isNew;
  final bool isPopular;

  PhotoBloc({
    required this.httpClient,
    this.isNew = false,
    this.isPopular = false}) : super(const PhotoState()) {
      on<PhotoFetched>(
          _onPhotoFetched,
          transformer: throttleDroppable(const Duration(milliseconds: 1500))
      );
    }

  Future<void> _onPhotoFetched(PhotoFetched event, Emitter<PhotoState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == PhotoStatus.initial) {
        final photos = await _fetchPhotos();
        return emit(state.copyWith(
          status: PhotoStatus.success,
          photos: photos,
          hasReachedMax: false,
        ));
      }
      final photos = await _fetchPhotos(state.photos.length);
      emit(photos.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
        status: PhotoStatus.success,
        photos: List.of(state.photos)..addAll(photos),
        hasReachedMax: false,
      ));
    } catch (_) {
      emit(state.copyWith(status: PhotoStatus.failure));
    }
  }

  Future<List<Photo>> _fetchPhotos([int startIndex = 1]) async {
    String requestUrl = Constants.apiRequest + '?';
    if (isNew) { requestUrl += 'new=' + isNew.toString() + '&'; }
    if (isPopular) { requestUrl += 'popular=' + isPopular.toString() + '&'; }
    requestUrl += 'page=' + startIndex.toString() + '&' + 'limit=14&';

    final http.Response response = await http.get(Uri.parse(requestUrl.toLowerCase()));
    if (response.statusCode == 200) {
      Iterable i = jsonDecode(response.body)['data'];
      return List<Photo>.from(i.map((model) => Photo.fromJson(model)));
    }
    throw Exception('Error fetching posts');
  }
}