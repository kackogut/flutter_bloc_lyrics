import 'package:flutter_bloc_lyrics/model/api/song_result.dart';

class SearchResult {
  final SearchItems searchItems;

  const SearchResult({required this.searchItems});

  static SearchResult fromJson(dynamic json) {
    return SearchResult(searchItems: SearchItems.fromJson(json["response"]));
  }
}

class SearchItems {
  final List<SongSearchResult> songs;

  const SearchItems({required this.songs});

  static SearchItems fromJson(Map<String, dynamic> json) {
    final items = (json['hits'] as List<dynamic>)
        .map(
          (dynamic item) =>
              SongSearchResult.fromJson(item as Map<String, dynamic>),
        )
        .toList();
    return SearchItems(songs: items);
  }
}
