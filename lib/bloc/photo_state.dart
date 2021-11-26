part of 'photo_bloc.dart';

abstract class PhotoState {}

class PhotoInitial extends PhotoState {}

class PhotoError extends PhotoState {
  String message = "";

  PhotoError([this.message = '']);

  @override
  String toString() {
    return 'PhotoError { message: $message }';
  }
}

class PhotoSuccess extends PhotoState {
  PhotoSuccess({
    required this.photos,
    this.hasReachedMax = false,
  });

  final List<PhotoEntity> photos;
  final bool hasReachedMax;

  PhotoSuccess copyWith({
    List<PhotoEntity>? photos,
    bool? hasReachedMax,
  }) {
    return PhotoSuccess(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'PhotoSuccess { hasReachedMax: $hasReachedMax, photos: ${photos.length} }';
  }

  List<Object> get props => [photos, hasReachedMax];
}
