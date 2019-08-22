import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc_lyrics/constants/secrets.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result.dart';
import 'package:flutter_bloc_lyrics/model/api/search_result_error.dart';
import 'package:http/http.dart' as http;


class LyricsClient {

  final http.Client httpClient;
  final String baseUrl = "https://api.genius.com/search?q=";

  LyricsClient({httpClient}): this.httpClient = httpClient ?? http.Client();


  Future<SearchResult> searchSongs(String query) async {
    final response = await httpClient.get(
        Uri.parse("$baseUrl$query"),
        headers: {HttpHeaders.authorizationHeader: "Bearer $GENIUS_KEY"},
    );
    final results = json.decode(response.body);

    if(response.statusCode == 200){
      return SearchResult.fromJson(results);
    } else {
      throw MetaResponse.fromJson(results).searchResultError;
    }
  }

}