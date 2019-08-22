import 'package:flutter_bloc_lyrics/model/api/song_result.dart';

//Mocked repository which works as remote client
class LocalClient {
  final List<SongResultItem> localSongsList = List();

  Future<void> addSong(SongResultItem song) async {
    await Future.delayed(Duration(microseconds: 100));
    localSongsList.add(song);
  }

  Future<List<SongSearchResult>> getSongs(String query) async {
    await Future.delayed(Duration(microseconds: 100));
    return localSongsList
        .where((song) => song.title.toLowerCase().contains(query))
        .map((song) => SongSearchResult(songResultItem: song));
  }

  Future<void> removeSong(int localID) async {
    await Future.delayed(Duration(microseconds: 100));
    localSongsList.removeAt(localID);
  }
}
