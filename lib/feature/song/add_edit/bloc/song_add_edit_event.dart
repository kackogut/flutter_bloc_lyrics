import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

abstract class SongAddEditEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class AddSong extends SongAddEditEvent {
  final LocalSong song;

  AddSong({required this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "AddSong { song ${song.id}";
}

class EditSong extends SongAddEditEvent {
  final LocalSong song;

  EditSong({required this.song});

  @override
  List<Object> get props => [song];

  @override
  String toString() => "EditSong { song ${song.id}";
}
