part of 'photo_bloc.dart';

abstract class PhotoEvent {
  List<Object> get props => [];
}

class PhotoFetched extends PhotoEvent {}