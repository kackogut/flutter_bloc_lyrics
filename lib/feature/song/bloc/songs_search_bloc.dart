import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
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
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<SongsSearchState> mapEventToState(SongEvent event) async* {
    if (event is TextChanged) {
      yield* _mapSongSearchTextChangedToState(event);
    }
    if(event is AddSong) {
      yield* _mapSongAddToState(event);
    }
  }

  Stream<SongsSearchState> _mapSongSearchTextChangedToState(TextChanged event) async* {
    final String searchQuery = event.query;
    if (searchQuery.isEmpty) {
      yield SearchStateEmpty();
    } else {
      yield SearchStateLoading();

      try {
        final result = await lyricsRepository.searchSongs(searchQuery);
        yield SearchStateSuccess(result);
      } catch (error) {
        yield error is SearchResultError
            ? SearchStateError(error.message)
            : SearchStateError("Default error");
      }
    }
  }

  Stream<SongsSearchState> _mapSongAddToState(AddSong event) async* {

    await lyricsRepository.addSong(event.song);
    //    if(currentState is SearchStateSuccess) {
//      yield SearchStateLoading();
//
//    }
  }

  @override
  void onTransition(Transition<SongEvent, SongsSearchState> transition) {
    print(transition);
  }
}
