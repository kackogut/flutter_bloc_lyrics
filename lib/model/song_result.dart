class SongResultItem {
  final String title;
  final String lyricsURL;
  final String thumbnailURL;

  const SongResultItem({this.title, this.lyricsURL, this.thumbnailURL});

  static SongResultItem fromJson(dynamic json) {
    return SongResultItem(
        title: json['full_title'] as String,
        lyricsURL: json['url'] as String,
        thumbnailURL: json['header_image_thumbnail_url'] as String);
  }
}
