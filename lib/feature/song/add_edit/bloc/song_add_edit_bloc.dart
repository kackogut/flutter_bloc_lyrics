import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit_state.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

class SongAddEditBloc extends Cubit<SongAddEditState> {
  final LyricsRepository lyricsRepository;

  SongAddEditBloc({required this.lyricsRepository}) : super(StateShowSong());

  Stream<SongAddEditState> addSong(LocalSong song) async* {
    yield StateLoading();
    SongBase updatedSong = await lyricsRepository.addSong(song);
    yield AddSongStateSuccess(updatedSong);
  }

  Stream<SongAddEditState> editSong(LocalSong song) async* {
    yield StateLoading();
    LocalSong updatedSong = await lyricsRepository.editSong(song);
    yield EditSongStateSuccess(updatedSong);
  }
}
