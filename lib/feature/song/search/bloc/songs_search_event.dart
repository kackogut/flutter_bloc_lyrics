import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongSearchEvent extends Equatable {
  SongSearchEvent([List props = const []]) : super(props);
}

class TextChanged extends SongSearchEvent {
  final String query;

  TextChanged({this.query}) : super([query]);

  @override
  String toString() => "SongSearchTextChanged { query: $query }";
}

class RemoveSong extends SongSearchEvent {
  final int songID;

  RemoveSong({this.songID}) : super([songID]);

  @override
  String toString() => "Remove song { songID: $songID }";
}

class UpdateSongs extends SongSearchEvent {
  final SongBase song;

  UpdateSongs({this.song}):super([song]);

  @override
  String toString() => "Update song { song: $song }";
}
