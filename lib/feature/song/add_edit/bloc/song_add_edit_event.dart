import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongAddEditEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AddSong extends SongAddEditEvent {
  final SongBase song;

  AddSong({this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "AddSong { song ${song.id}";
}

class EditSong extends SongAddEditEvent {
  final SongBase song;

  EditSong({this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "EditSong { song ${song.id}";
}
