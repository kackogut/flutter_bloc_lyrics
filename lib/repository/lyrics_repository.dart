import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/local_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';

class LyricsRepository {
  final LyricsClient client;
  final LocalClient localClient;

  LyricsRepository(this.client, this.localClient);

  Future<List<SongBase>> searchSongs(String query) async {
    final networkList = await client.searchSongs(query);
    final localList = await localClient.getSongs(query);
    return List<SongBase>.empty(growable: true)
      ..addAll(networkList)
      ..addAll(localList);
  }

  Future<void> removeSong(int songIndex) async {
    await localClient.removeSong(songIndex);
  }

  Future<SongBase> addSong(LocalSong song) async {
    return await localClient.addSong(song);
  }

  Future<LocalSong> editSong(LocalSong song) async {
    return await localClient.editSong(song);
  }
}
