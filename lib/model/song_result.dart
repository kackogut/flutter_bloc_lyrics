class SongResult {
  final String title;
  final String lyricsURL;
  final String thumbnailURL;

  const SongResult({this.title, this.lyricsURL, this.thumbnailURL});

  static SongResult fromJson(dynamic json) {
    return SongResult(
        title: json['full_title'] as String,
        lyricsURL: json['url'] as String,
        thumbnailURL: json['header_image_thumbnail_url'] as String);
  }
}
