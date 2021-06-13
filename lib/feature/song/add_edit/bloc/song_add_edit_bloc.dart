import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit_state.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

class SongAddEditBloc extends Cubit<SongAddEditState> {
  final LyricsRepository lyricsRepository;

  SongAddEditBloc({required this.lyricsRepository}) : super(StateShowSong());

  Future<void> addSong(LocalSong song) async {
    emit(StateLoading());
    SongBase updatedSong = await lyricsRepository.addSong(song);
    emit(AddSongStateSuccess(updatedSong));
  }

  Future<void> editSong(LocalSong song) async {
    emit(StateLoading());
    LocalSong updatedSong = await lyricsRepository.editSong(song);
    emit(EditSongStateSuccess(updatedSong));
  }
}
