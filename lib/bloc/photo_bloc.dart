import 'dart:async';

import 'package:pictures/api/request_api.dart';
import 'package:pictures/dto/photo_entity.dart';
import 'package:pictures/dto/response_data.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'photo_event.dart';

part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final bool isNew;
  final bool isPopular;

  int _page = 0;
  final List<PhotoEntity> _photos = [];
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

  Future<void> _onPhotoFetched(
      PhotoFetched event, Emitter<PhotoState> emit) async {
    try {
      _page++;
      RequestApi requestApi = RequestApi();
      ResponseData responseData = await requestApi.getPhotos(
        isNew: isNew,
        isPopular: isPopular,
        page: _page,
        limit: _limit,
      );
      int pageCount = responseData.countOfPages;
      final List<PhotoEntity> photos = responseData.data as List<PhotoEntity>;
      if (_page <= pageCount) {
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

  Future<void> _onPhotoRefreshed(
      PhotoRefreshed event, Emitter<PhotoState> emit) async {
    try {
      _page = 1;
      RequestApi requestApi = RequestApi();
      ResponseData responseData = await requestApi.getPhotos(
        isNew: isNew,
        isPopular: isPopular,
        page: _page,
        limit: _limit,
      );
      final List<PhotoEntity> photos = responseData.data as List<PhotoEntity>;
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
  }
}
