import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/network_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/model/mapper/song_mapper.dart';

class LocalClient {
  final List<LocalSong> localSongsList = List.empty(growable: true);

  Future<SongBase> addSong(LocalSong song) async {
    await Future.delayed(Duration(milliseconds: 100));
    LocalSong addedSong = song.copyWith(id: localSongsList.length);
    localSongsList.add(addedSong);
    return addedSong;
  }

  Future<LocalSong> editSong(LocalSong song) async {
    await Future.delayed(Duration(milliseconds: 1000));
    localSongsList[song.id] = song;
    return song;
  }

  Future<List<LocalSong>> getSongs(String query) async {
    await Future.delayed(Duration(milliseconds: 1000));
    return localSongsList
        .where((song) => song.title.toLowerCase().contains(query))
        .toList();
  }

  Future<void> removeSong(int localID) async {
    await Future.delayed(Duration(milliseconds: 1000));
    localSongsList.removeAt(localID);
  }
}
