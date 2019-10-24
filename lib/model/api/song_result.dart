import 'package:flutter_bloc_lyrics/model/song_base.dart';

class SongSearchResult {
  final SongResultItem songResultItem;

  const SongSearchResult({this.songResultItem});

  static SongSearchResult fromJson(dynamic json) {
    return SongSearchResult(
        songResultItem: SongResultItem.fromJson(json['result']));
  }
}

class SongResultItem extends SongBase {
  const SongResultItem({title, lyricsURL, thumbnailURL})
      : super(title: title, lyricsURL: lyricsURL, albumThumbnail: thumbnailURL);

  static SongResultItem fromJson(dynamic json) {
    return SongResultItem(
        title: json['title'] as String,
        lyricsURL: json['url'] as String,
        thumbnailURL: json['header_image_thumbnail_url'] as String);
  }
}
