import 'package:flutter_bloc_lyrics/model/api/search_result.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';
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
    resultLocal.addAll(resultAPI.songs.map((song)=> song.songResultItem));
    return resultLocal;
  }

  Future<void> removeSong(int songIndex) async {
    await localClient.removeSong(songIndex);
  }

  Future<void> addSong(SongBase song) async{
    await localClient.addSong(song);
  }
}