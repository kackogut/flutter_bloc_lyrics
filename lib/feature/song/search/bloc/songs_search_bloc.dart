import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/common/constants.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:rxdart/rxdart.dart';

class SongsSearchBloc extends Bloc<SongSearchEvent, SongsSearchState> {
  final LyricsRepository lyricsRepository;
  final SongAddEditBloc songAddEditBloc;

  late StreamSubscription addEditBlocSubscription;

  SongsSearchBloc({
    required this.lyricsRepository,
    required this.songAddEditBloc,
  }) : super(SearchStateEmpty()) {
    addEditBlocSubscription = songAddEditBloc.stream.listen((songAddEditState) {
      if (state is SearchStateSuccess) {
        if (songAddEditState is EditSongStateSuccess) {
          add(SongUpdated(song: songAddEditState.song));
        } else if (songAddEditState is AddSongStateSuccess) {
          add(SongAdded(song: songAddEditState.song));
        }
      }
    });
  }

  @override
  Stream<Transition<SongSearchEvent, SongsSearchState>> transformEvents(
    Stream<SongSearchEvent> events,
    TransitionFunction<SongSearchEvent, SongsSearchState> transitionFn,
  ) {
    final nonDebounceStream = events.where((event) => event is! TextChanged);

    final debounceStream =
        events.where((event) => event is TextChanged).debounceTime(
              Duration(milliseconds: DEFAULT_SEARCH_DEBOUNCE),
            );

    return super.transformEvents(
      MergeStream([nonDebounceStream, debounceStream]),
      transitionFn,
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
    if (event is SongUpdated) {
      yield* _mapSongUpdateToState(event);
    }
    if (event is SongAdded) {
      yield* _mapSongAddedToState(event);
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
    if (state is SearchStateSuccess) {
      SearchStateSuccess searchState = state as SearchStateSuccess;
      searchState.songs.removeWhere((song) {
        return song.id == event.songID;
      });
      yield SearchStateSuccess(searchState.songs, searchState.query);
    }
  }

  Stream<SongsSearchState> _mapSongUpdateToState(SongUpdated event) async* {
    if (state is SearchStateSuccess) {
      SearchStateSuccess successState = state as SearchStateSuccess;
      List<SongBase> updatedList = successState.songs;
      if (event.song.isInQuery(successState.query)) {
        updatedList = updatedList.map((song) {
          return song.id == event.song.id ? event.song : song;
        }).toList();
      } else {
        updatedList.removeWhere((song) => song.id == event.song.id);
      }
      yield SearchStateSuccess(updatedList, successState.query);
    }
  }

  Stream<SongsSearchState> _mapSongAddedToState(SongAdded event) async* {
    if (state is SearchStateSuccess) {
      SearchStateSuccess successState = state as SearchStateSuccess;
      List<SongBase> updatedList = List.from(successState.songs);

      if (event.song.isInQuery(successState.query)) {
        updatedList.insert(0, event.song);
        yield SearchStateSuccess(updatedList, successState.query);
      }
    }
  }

  @override
  Future<void> close() {
    addEditBlocSubscription.cancel();
    return super.close();
  }
}
