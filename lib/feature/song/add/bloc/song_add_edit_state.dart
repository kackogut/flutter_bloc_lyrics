import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongAddEditState extends Equatable {
  SongAddEditState([List props = const []]) : super(props);
}

class StateEmpty extends SongAddEditState {
  @override
  String toString() => 'SearchStateEmpty';
}

class StateLoading extends SongAddEditState {
  @override
  String toString() => 'SearchStateLoading';
}

class AddSongStateSuccess extends SongAddEditState {
  @override
  String toString() => 'AddSongSuccess';
}

class EditSongStateSuccess extends SongAddEditState {
  final SongBase song;

  EditSongStateSuccess(this.song) : super([song]);

  @override
  String toString() => 'EditSongSuccess {song: $song }';
}
