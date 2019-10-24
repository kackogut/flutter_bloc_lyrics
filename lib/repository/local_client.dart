import 'package:flutter_bloc_lyrics/model/song_base.dart';

//Mocked repository which works as remote client
class LocalClient {
  final List<SongBase> localSongsList = List();

  Future<SongBase> addSong(SongBase song) async {
    await Future.delayed(Duration(microseconds: 100));
    SongBase addedSong = song.copyWith(id: localSongsList.length);
    localSongsList.add(addedSong);
    return addedSong;
  }

  Future<SongBase> editSong(SongBase song) async {
    await Future.delayed(Duration(microseconds: 100));
    localSongsList[song.id] = song;
    return song;
  }

  Future<List<SongBase>> getSongs(String query) async {
    await Future.delayed(Duration(microseconds: 100));
    return localSongsList
        .where((song) => song.title.toLowerCase().contains(query))
        .toList();
  }

  Future<void> removeSong(int localID) async {
    await Future.delayed(Duration(microseconds: 100));
    localSongsList.removeAt(localID);
  }
}
