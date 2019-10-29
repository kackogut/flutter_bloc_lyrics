import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/repository/local_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';

class LyricsRepository {
  final LyricsClient client;
  final LocalClient localClient;

  LyricsRepository(this.client, this.localClient);

  Future<List<SongBase>> searchSongs(String query) async {
    final resultAPI = await client.searchSongs(query);
    final resultLocal = await localClient.getSongs(query);
    resultLocal.addAll(resultAPI.songs.map((song) => song.songResultItem));
    return resultLocal;
  }

  Future<void> removeSong(int songIndex) async {
    await localClient.removeSong(songIndex);
  }

  Future<SongBase> addSong(SongBase song) async {
    return localClient.addSong(song);
  }

  Future<SongBase> editSong(SongBase song) async {
    return await localClient.editSong(song);
  }
}
