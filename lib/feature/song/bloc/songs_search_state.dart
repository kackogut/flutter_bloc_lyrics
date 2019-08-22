import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';

abstract class SongsSearchState extends Equatable {
  SongsSearchState([List props = const []]) : super(props);
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
  final List<SongSearchResult> songs;

  SearchStateSuccess(this.songs) : super([songs]);

  @override
  String toString() => 'SearchStateSuccess { songs: ${songs.length} }';
}

class SearchStateError extends SongsSearchState {
  final String error;

  SearchStateError(this.error) : super([error]);

  @override
  String toString() => 'SearchStateError { error: $error }';
}
