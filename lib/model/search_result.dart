import 'package:flutter_bloc_lyrics/model/song_result.dart';

class SearchResult {
  final SearchItems searchItems;

  const SearchResult({this.searchItems});

  static SearchResult fromJson(dynamic json){
    return SearchResult(searchItems: SearchItems.fromJson(json["response"]));
  }
}

class SearchItems {
  final List<SongResult> songs;

  const SearchItems({this.songs});

  static SearchItems fromJson(Map<String, dynamic> json) {
    final items = (json['hits'] as List<dynamic>)
        .map((dynamic item) =>
          SongResult.fromJson(item as Map<String, dynamic>))
        .toList();
    return SearchItems(songs: items);
  }
}