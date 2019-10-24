import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongEvent extends Equatable {
  SongEvent([List props = const []]) : super(props);
}

class TextChanged extends SongEvent {
  final String query;

  TextChanged({this.query}) : super([query]);

  @override
  String toString() => "SongSearchTextChanged { query: $query }";
}

class AddSong extends SongEvent {
  final SongBase song;

  AddSong({this.song}) : super([song]);

  @override
  String toString() => "AddSong { song ${song.id}";
}

class EditSong extends SongEvent {
  final SongBase song;

  EditSong({this.song}) : super([song]);

  @override
  String toString() => "EditSong { song ${song.id}";
}

class RemoveSong extends SongEvent {
  final int songID;

  RemoveSong({this.songID}) : super([songID]);

  @override
  String toString() => "Remove song { songID: $songID }";
}
