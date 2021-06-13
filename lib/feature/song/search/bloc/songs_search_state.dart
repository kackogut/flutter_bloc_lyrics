import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

abstract class SongsSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStateEmpty extends SongsSearchState {
  @override
  String toString() => 'SearchStateEmpty';
}

class SearchStateLoading extends SongsSearchState {
  @override
  String toString() => 'SearchStateLoading';
}

class SearchStateSuccess extends SongsSearchState {
  final List<SongBase> songs;
  final String query;

  SearchStateSuccess(this.songs, this.query);

  @override
  List<Object> get props => [songs, query];

  @override
  String toString() => 'SearchStateSuccess { songs: ${songs.length} }';
}

class SearchStateError extends SongsSearchState {
  final String error;

  SearchStateError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'SearchStateError { error: $error }';
}
