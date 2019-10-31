import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLyricsRepository extends Mock implements LyricsRepository {}

class MockSongBase extends Mock implements SongBase {}

void main() {
  SongAddEditBloc songAddEditBloc;
  SongsSearchBloc songsSearchBloc;
  MockLyricsRepository lyricsRepository;

  String query = "query.test";
  List<SongBase> songsList = List();

  setUp(() {
    lyricsRepository = MockLyricsRepository();
    songAddEditBloc = SongAddEditBloc(lyricsRepository: lyricsRepository);
    songsSearchBloc = SongsSearchBloc(lyricsRepository: lyricsRepository, songAddEditBloc: songAddEditBloc);
  });

  tearDown(() {
    songAddEditBloc?.close();
    songsSearchBloc?.close();
  });

  test('after initialization bloc state is correct', () {
    expect(SearchStateEmpty(), songsSearchBloc.initialState);
  });

  test('after closing bloc does not emit any states', () {
    expectLater(songsSearchBloc, emitsInOrder([SearchStateEmpty(), emitsDone]));

    songsSearchBloc.close();
  });

  test('emits success state after insering lyrics search query', () {

    songsList.add(MockSongBase());

    final expectedResponse = [
      SearchStateEmpty(),
      SearchStateLoading(),
      SearchStateSuccess(songsList, query)
    ];

    when(lyricsRepository.searchSongs(query))
        .thenAnswer((_) => Future.value(songsList));

    expectLater(songsSearchBloc, emitsInOrder(expectedResponse));

    songsSearchBloc.add(TextChanged(query: query));
  });

  test('emits state success with new song, after adding it in addEditBloc and song is in query',(){
    //TODO:Add
  });

  test('emits update state with updated song, after updating it in addEditBloc and song is in query',(){
    //TODO:Add
  });

  test('removes song from repository when remove event is sent',(){
    //TODO:Add
  });
}
