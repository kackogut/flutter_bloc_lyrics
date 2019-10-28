import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/common/constants.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

class SongsSearchBloc extends Bloc<SongSearchEvent, SongsSearchState> {
  final LyricsRepository lyricsRepository;

  SongsSearchBloc({@required this.lyricsRepository});

  @override
  SongsSearchState get initialState => SearchStateEmpty();

  @override
  Stream<SongsSearchState> transformEvents(Stream<SongSearchEvent> events,
      Stream<SongsSearchState> Function(SongSearchEvent event) next) {
    return super.transformEvents(
      (events as Observable<SongSearchEvent>).debounceTime(
        Duration(milliseconds: DEFAULT_SEARCH_DEBOUNCE),
      ),
      next,
    );
  }

  @override
  Stream<SongsSearchState> mapEventToState(SongSearchEvent event) async* {
    if (event is TextChanged) {
      yield* _mapSongSearchTextChangedToState(event);
    }
    if (event is RemoveSong) {
      yield* _mapSongRemoveToState(event);
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

  Stream<SongsSearchState> _mapSongRemoveToState(RemoveSong event) async* {
    await lyricsRepository.removeSong(event.songID);
    if(state is SearchStateSuccess){
      SearchStateSuccess searchState = state;
      searchState.songs.removeWhere((song){
        return song.id == event.songID;
      });
      yield SearchStateSuccess(searchState.songs, searchState.query);
    }
  }

  @override
  void onTransition(Transition<SongSearchEvent, SongsSearchState> transition) {
    print(transition);
  }
}
