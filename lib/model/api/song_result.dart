import 'package:flutter_bloc_lyrics/model/api/song_artist.dart';

class SongSearchResult {
  final SongResultItem songResultItem;

  const SongSearchResult({required this.songResultItem});

  static SongSearchResult fromJson(dynamic json) {
    return SongSearchResult(
      songResultItem: SongResultItem.fromJson(json['result']),
    );
  }
}

class SongResultItem {
  final int id;
  final String title;
  final String artist;
  final String lyricsURL;
  final String albumThumbnail;

  const SongResultItem({
    required this.id,
    required this.title,
    required this.lyricsURL,
    required this.albumThumbnail,
    required this.artist,
  });

  static SongResultItem fromJson(dynamic json) {
    return SongResultItem(
      id: json['id'] as int,
      title: json['title'] as String,
      lyricsURL: json['url'] as String,
      albumThumbnail: json['header_image_thumbnail_url'] as String,
      artist: Artist.fromJson(json['primary_artist']).name,
    );
  }
}
