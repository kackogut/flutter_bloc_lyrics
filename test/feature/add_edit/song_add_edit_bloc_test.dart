import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLyricsRepository extends Mock implements LyricsRepository {}

class MockSongBase extends Mock implements SongBase {}

void main() {
  late SongAddEditBloc songAddEditBloc;
  late MockLyricsRepository lyricsRepository;

  setUp(() {
    lyricsRepository = MockLyricsRepository();
    songAddEditBloc = SongAddEditBloc(lyricsRepository: lyricsRepository);
  });

  tearDown(() {
    songAddEditBloc.close();
  });

  test('after initialization bloc state is correct', () async {
    expect(StateShowSong(), songAddEditBloc.state);
  });

  test('after closing bloc does not emit any states', () async {
    expectLater(songAddEditBloc, emitsInOrder([StateShowSong(), emitsDone]));

    songAddEditBloc.close();
  });

  test('after adding a song songAddedState should be emited', () async {

    MockSongBase songToAdd = MockSongBase();

    final expectedResponse = [
      StateShowSong(),
      StateLoading(),
      AddSongStateSuccess(songToAdd)
    ];

    when(lyricsRepository.addSong(songToAdd))
        .thenAnswer((_) => Future.value(songToAdd));

    expectLater(songAddEditBloc, emitsInOrder(expectedResponse));

    songAddEditBloc.add(AddSong(song:songToAdd));
  });

  test('after editing a song songEditedState should be emited', () async {

    MockSongBase songToAdd = MockSongBase();

    final expectedResponse = [
      StateShowSong(),
      StateLoading(),
      EditSongStateSuccess(songToAdd)
    ];

    when(lyricsRepository.editSong(songToAdd))
        .thenAnswer((_) => Future.value(songToAdd));

    expectLater(songAddEditBloc, emitsInOrder(expectedResponse));

    songAddEditBloc.add(EditSong(song:songToAdd));
  });
}
