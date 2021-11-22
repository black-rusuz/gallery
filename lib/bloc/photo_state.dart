part of 'photo_bloc.dart';

abstract class PhotoState {

}

class PhotoError extends PhotoState {
  String message = "";
}

class PhotoInitial extends PhotoState {}

class PhotoEmptyList extends PhotoState {}

class PhotoSuccess extends PhotoState {
  PhotoSuccess({
    required this.photos,
    this.hasReachedMax = false,
  });

  final List<Photo> photos;
  final bool hasReachedMax;

  PhotoSuccess copyWith({
    List<Photo>? photos,
    bool? hasReachedMax,
  }) {
    return PhotoSuccess(
      photos: photos ?? this.photos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'PhotoState { hasReachedMax: $hasReachedMax, photos: ${photos.length} }';
  }

  List<Object> get props => [photos, hasReachedMax];
}
