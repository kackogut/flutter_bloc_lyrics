import 'package:flutter_bloc_lyrics/model/api/search_result.dart';

import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';

class LyricsRepository {

  final LyricsClient client;

  LyricsRepository(this.client);

  Future<SearchItems> searchSongs(String query) async {
    final result = await client.searchSongs(query);
    return result.searchItems;
  }
}