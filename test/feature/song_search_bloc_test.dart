import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/repository/local_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLyricsRepository extends Mock implements LyricsRepository {}

void main(){
  SongsSearchBloc songsSearchBloc;
  MockLyricsRepository lyricsRepository;

  setUp((){
    lyricsRepository = MockLyricsRepository();
    songsSearchBloc = SongsSearchBloc(lyricsRepository: lyricsRepository);
  });

  tearDown((){
    songsSearchBloc?.close();
  });

  test('initial state is correct', (){
    expect(SearchStateEmpty(), songsSearchBloc.initialState);
  });
}
