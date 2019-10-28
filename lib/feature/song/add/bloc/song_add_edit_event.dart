import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

abstract class SongAddEditEvent extends Equatable{
  SongAddEditEvent([List props = const []]) : super(props);
}

class AddSong extends SongAddEditEvent {
  final SongBase song;

  AddSong({this.song}) : super([song]);

  @override
  String toString() => "AddSong { song ${song.id}";
}

class EditSong extends SongAddEditEvent {
  final SongBase song;

  EditSong({this.song}) : super([song]);

  @override
  String toString() => "EditSong { song ${song.id}";
}
