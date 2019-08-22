import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
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
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  Stream<SongsSearchState> mapEventToState(SongSearchEvent event) async* {
    if (event is TextChanged) {
      final String searchQuery = event.query;
      if (searchQuery.isEmpty) {
        yield SearchStateEmpty();
      } else {
        yield SearchStateLoading();

        try {
          final result = await lyricsRepository.searchSongs(searchQuery);
          yield SearchStateSuccess(result.songs);
        } catch (error) {
          //TODO Add localization to default error
          yield error is SearchResultError
              ? SearchStateError(error.message)
              : SearchStateError("Default error");
        }
      }
    }
  }

  @override
  void onTransition(Transition<SongSearchEvent, SongsSearchState> transition) {
    print(transition);
  }
}
