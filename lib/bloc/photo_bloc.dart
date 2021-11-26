import 'dart:async';

import 'package:pictures/api/request_api.dart';
import 'package:pictures/dto/response_data.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:pictures/dto/photo.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final bool isNew;
  final bool isPopular;

  int _page = 1;
  final List<Photo> _photos = [];
  final int _limit = 14;

  EventTransformer<E> throttleDroppable<E>(Duration duration) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  PhotoBloc({this.isNew = false, this.isPopular = false})
      : super(PhotoInitial()) {
    on<PhotoFetched>(
      _onPhotoFetched,
      transformer: throttleDroppable(const Duration(seconds: 1)),
    );
    on<PhotoRefreshed>(_onPhotoRefreshed);
  }

  Future<void> _onPhotoFetched(PhotoFetched event,
      Emitter<PhotoState> emit) async {
    try {
      RequestApi requestApi = RequestApi();
      ResponseData responseData = await requestApi.getPhotos(
        isNew: isNew,
        isPopular: isPopular,
        page: _page,
        limit: _limit,
      );
      int pageCount = responseData.countOfPages;
      List<Photo> photos = responseData.data as List<Photo>;
      if (_page <= pageCount) {
        _page++;
        _photos.addAll(photos);
      }
      if (photos.isEmpty || photos.length < _limit) {
        emit(PhotoSuccess(photos: _photos, hasReachedMax: true));
      } else {
        emit(PhotoSuccess(photos: _photos));
      }
    } catch (e) {
      emit(PhotoError(e.toString()));
    }
  }

Future<void> _onPhotoRefreshed(PhotoRefreshed event,
    Emitter<PhotoState> emit) async {
  RequestApi requestApi = RequestApi();
  ResponseData responseData = await requestApi.getPhotos();
  try {
    _page = 1;
    final List<Photo> photos = await requestApi.getPhotosList(
      isNew: isNew,
      isPopular: isPopular,
      page: _page,
      limit: _limit,
    );
    _photos.clear();
    _photos.addAll(photos);
    if (photos.isEmpty || photos.length < _limit) {
      emit(PhotoSuccess(photos: _photos, hasReachedMax: true));
    } else {
      emit(PhotoSuccess(photos: _photos));
    }
  } catch (e) {
    emit(PhotoError(e.toString()));
  }
}}
