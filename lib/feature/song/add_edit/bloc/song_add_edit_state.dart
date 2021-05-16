import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongAddEditState extends Equatable {
  @override
  List<Object> get props => [];
}

class StateShowSong extends SongAddEditState {
  @override
  String toString() => 'SearchStateEmpty';
}

class StateLoading extends SongAddEditState {
  @override
  String toString() => 'SearchStateLoading';
}

class AddSongStateSuccess extends SongAddEditState {
  final SongBase song;

  AddSongStateSuccess(this.song);

  @override
  List<Object> get props => [song];

  @override
  String toString() => 'AddSongSuccess {song: $song }';
}

class EditSongStateSuccess extends SongAddEditState {
  final SongBase song;

  EditSongStateSuccess(this.song);

  @override
  List<Object> get props => [song];

  @override
  String toString() => 'EditSongSuccess {song: $song }';
}
