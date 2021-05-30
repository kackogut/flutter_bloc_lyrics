import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit_state.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

class SongAddEditBloc extends Bloc<SongAddEditEvent, SongAddEditState> {
  final LyricsRepository lyricsRepository;

  SongAddEditBloc({required this.lyricsRepository}) : super(StateShowSong());

  @override
  Stream<SongAddEditState> mapEventToState(SongAddEditEvent event) async* {
    if (event is AddSong) {
      yield* _mapSongAddToState(event);
    }
    if (event is EditSong) {
      yield* _mapSongEditToState(event);
    }
  }

  Stream<SongAddEditState> _mapSongAddToState(AddSong event) async* {
    yield StateLoading();
    SongBase updatedSong = await lyricsRepository.addSong(event.song);
    yield AddSongStateSuccess(updatedSong);
  }

  Stream<SongAddEditState> _mapSongEditToState(EditSong event) async* {
    yield StateLoading();
    SongBase updatedSong = await lyricsRepository.editSong(event.song);
    yield EditSongStateSuccess(updatedSong);
  }
}
