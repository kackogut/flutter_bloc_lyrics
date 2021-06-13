import 'package:flutter/foundation.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLyricsRepository extends Mock implements LyricsRepository {}

class MockSongBase extends Mock implements SongBase {}

class MockAddEditBloc extends Mock implements SongAddEditBloc {}

SongBase songInList = MockSongBase();

void main() {
  late SongAddEditBloc songAddEditBloc;
  late SongsSearchBloc songsSearchBloc;
  late MockLyricsRepository lyricsRepository;

  String query = "query.test";
  List<SongBase> songsList = List.empty();
  int songToRemoveID = 1;

  setUp(() {
    lyricsRepository = MockLyricsRepository();
    songAddEditBloc = SongAddEditBloc(lyricsRepository: lyricsRepository);
    songsSearchBloc = SongsSearchBloc(
        lyricsRepository: lyricsRepository, songAddEditBloc: songAddEditBloc);

    when(lyricsRepository.searchSongs(query))
        .thenAnswer((_) => Future.value(songsList));

    when(songInList.id).thenAnswer((_) {
      return songToRemoveID;
    });
    songsList.add(songInList);
  });

  tearDown(() {
    songAddEditBloc.close();
    songsSearchBloc.close();
  });

  test('after initialization bloc state is correct', () async {
    await expectLater(SearchStateEmpty(), songsSearchBloc.state);
  });

  test('after closing bloc does not emit any states', () async {
    expectLater(songsSearchBloc, emitsInOrder([SearchStateEmpty(), emitsDone]));

    songsSearchBloc.close();
  });

  Future fetchList() async {
    final expectedResponse = [
      SearchStateEmpty(),
      SearchStateLoading(),
      SearchStateSuccess(songsList, query),
    ];

    expectLater(songsSearchBloc, emitsInOrder(expectedResponse));

    songsSearchBloc.add(TextChanged(query: query));

    await Future.delayed(const Duration(seconds: 1), () {});
  }

  test('emits success state after insering lyrics search query', () async {
    fetchList();
  });

  test(
      'emits state success with new song, after adding it in addEditBloc and song is in query',
      () async {
    await fetchList();

    MockSongBase songToAdd = MockSongBase();

    when(songToAdd.isInQuery(query)).thenAnswer((_){return true;});

    List<SongBase> songList = List.from((songsSearchBloc.state as SearchStateSuccess).songs);
    songList.insert(0, songToAdd);
    songsSearchBloc.add(SongAdded(song: songToAdd));
    await Future.delayed(const Duration(seconds: 1), () {});
    SearchStateSuccess stateSuccess = songsSearchBloc.state as SearchStateSuccess;
    assert (listEquals(stateSuccess.songs, songList));
  });

  test('removes song from repository when remove event is sent', () async {
    await fetchList();

    expectLater(
        songsSearchBloc, emitsInOrder([SearchStateSuccess(songsList, query)]));

    songsSearchBloc.add(RemoveSong(songID: songToRemoveID));
  });
}
