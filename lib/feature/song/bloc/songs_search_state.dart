import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

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
  final List<SongBase> songs;
  final String query;

  SearchStateSuccess(this.songs, this.query) : super([songs]);

  @override
  String toString() => 'SearchStateSuccess { songs: ${songs.length} }';
}

class AddEditSongStateSuccess extends SongsSearchState {
  @override
  String toString() => 'AddSongSuccess';
}

class SearchStateError extends SongsSearchState {
  final String error;

  SearchStateError(this.error) : super([error]);

  @override
  String toString() => 'SearchStateError { error: $error }';
}
