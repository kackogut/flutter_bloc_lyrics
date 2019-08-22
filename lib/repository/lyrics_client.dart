import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_lyrics/constants/secrets.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';
import 'package:http/http.dart' as http;

import 'local_client.dart';

class LyricsClient {
  final http.Client httpClient;
  final LocalClient localClient;

  final String baseUrl = "https://api.genius.com/search?q=";

  LyricsClient({httpClient, localClient})
      : this.httpClient = httpClient ?? http.Client(),
        this.localClient = localClient ?? LocalClient();

  Future<SearchItems> searchSongs(String query) async {
    final response = await httpClient.get(
      Uri.parse("$baseUrl$query"),
      headers: {HttpHeaders.authorizationHeader: "Bearer $GENIUS_KEY"},
    );
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      SearchItems searchResult = SearchResult.fromJson(results).searchItems;
      searchResult.songs.addAll(await localClient.getSongs(query));

      return SearchResult.fromJson(results).searchItems;
    } else {
      throw MetaResponse.fromJson(results).searchResultError;
    }
  }

  Future<void> removeSong(int songIndex){
    return localClient.removeSong(songIndex);
  }

  Future<void> addSong(SongResultItem song){
    return localClient.addSong(song);
  }
}
