import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/common/constants.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SongsSearchBloc extends Bloc<SongEvent, SongsSearchState> {
  final LyricsRepository lyricsRepository;

  SongsSearchBloc({@required this.lyricsRepository});

  @override
  SongsSearchState get initialState => SearchStateEmpty();

  @override
  Stream<SongsSearchState> transformEvents(Stream<SongEvent> events,
      Stream<SongsSearchState> Function(SongEvent event) next) {
    return super.transformEvents(
      (events as Observable<SongEvent>).debounceTime(
        Duration(milliseconds: DEFAULT_SEARCH_DEBOUNCE),
      ),
      next,
    );
  }

  @override
  Stream<SongsSearchState> mapEventToState(SongEvent event) async* {
    if (event is TextChanged) {
      yield* _mapSongSearchTextChangedToState(event);
    }
    if (event is AddSong) {
      yield* _mapSongAddToState(event);
    }
    if (event is RemoveSong) {
      yield* _mapSongRemoveToState(event);
    }
    if (event is EditSong) {
      yield* _mapSongEditToState(event);
    }
  }

  Stream<SongsSearchState> _mapSongSearchTextChangedToState(
      TextChanged event) async* {
    final String searchQuery = event.query;
    if (searchQuery.isEmpty) {
      yield SearchStateEmpty();
    } else {
      yield SearchStateLoading();

      try {
        final result = await lyricsRepository.searchSongs(searchQuery);
        yield SearchStateSuccess(result, searchQuery);
      } catch (error) {
        yield error is SearchResultError
            ? SearchStateError(error.message)
            : SearchStateError("Default error");
      }
    }
  }

  Stream<SongsSearchState> _mapSongAddToState(AddSong event) async* {
    SongBase updatedSong = await lyricsRepository.addSong(event.song);
    if (currentState is SearchStateSuccess) {
      SearchStateSuccess state = currentState;
      List<SongBase> updatedList = (currentState as SearchStateSuccess).songs;

      yield AddEditSongStateSuccess();

      if (updatedSong.isInQuery(state.query)) {
        updatedList..insert(0, updatedSong);
      }
      yield SearchStateSuccess(updatedList, state.query);
    } else {
      yield AddEditSongStateSuccess();
    }
  }

  Stream<SongsSearchState> _mapSongRemoveToState(RemoveSong event) async* {
    await lyricsRepository.removeSong(event.songID);
//    if(state is SearchStateSuccess){
//      SearchStateSuccess state = currentState;
//      yield SearchStateSuccess(state.songs, state.query);
//    }
  }

  Stream<SongsSearchState> _mapSongEditToState(EditSong event) async* {
    SongBase updatedSong = await lyricsRepository.editSong(event.song);
    if (currentState is SearchStateSuccess) {
      yield AddEditSongStateSuccess();
    } else {
      yield AddEditSongStateSuccess();
    }
  }

  @override
  void onTransition(Transition<SongEvent, SongsSearchState> transition) {
    print(transition);
  }
}
