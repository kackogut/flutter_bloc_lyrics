import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/bloc/song_add_edit_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/bloc/song_add_edit_state.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:meta/meta.dart';

class SongAddEditBloc extends Bloc<SongAddEditEvent, SongAddEditState> {
  final LyricsRepository lyricsRepository;

  SongAddEditBloc({@required this.lyricsRepository});

  @override
  SongAddEditState get initialState => StateEmpty();

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
    SongBase updatedSong = await lyricsRepository.addSong(event.song);
    yield AddSongStateSuccess();
//    if (state is SearchStateSuccess) {
//      SearchStateSuccess searchState = state;
//      List<SongBase> updatedList = (state as SearchStateSuccess).songs;
//
//      yield AddSongStateSuccess();
//
//      if (updatedSong.isInQuery(searchState.query)) {
//        updatedList..insert(0, updatedSong);
//      }
//      yield SearchStateSuccess(updatedList, searchState.query);
//    } else {
//
//    }
  }


  Stream<SongAddEditState> _mapSongEditToState(EditSong event) async* {
    SongBase updatedSong = await lyricsRepository.editSong(event.song);
    yield EditSongStateSuccess(updatedSong);
//    if (state is SearchStateSuccess) {
//      yield EditSongStateSuccess(updatedSong);
//      SearchStateSuccess searchState = state;
//      List<SongBase> updatedList = searchState.songs;
//      if (updatedSong.isInQuery(searchState.query)) {
//        updatedList = updatedList.map((song) {
//          return song.id == updatedSong.id ? updatedSong : song;
//        }).toList();
//      } else {
//        updatedList.removeWhere((song)=> song.id == updatedSong.id);
//      }
//      yield SearchStateSuccess(updatedList, searchState.query);
//    } else {
//
//    }
  }

  @override
  void onTransition(Transition<SongAddEditEvent, SongAddEditState> transition) {
    print(transition);
  }
}
