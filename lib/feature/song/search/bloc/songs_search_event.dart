import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

abstract class SongSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TextChanged extends SongSearchEvent {
  final String query;

  TextChanged({required this.query});

  @override
  List<Object> get props => [query];

  @override
  String toString() => "SongSearchTextChanged { query: $query }";
}

class RemoveSong extends SongSearchEvent {
  final int songID;

  RemoveSong({required this.songID});

  @override
  List<Object> get props => [songID];

  @override
  String toString() => "Remove song { songID: $songID }";
}

class SongUpdated extends SongSearchEvent {
  final SongBase song;

  SongUpdated({required this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "Update song { song: $song }";
}

class SongAdded extends SongSearchEvent {
  final SongBase song;

  SongAdded({required this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "AddedSong { song: $song }";
}
