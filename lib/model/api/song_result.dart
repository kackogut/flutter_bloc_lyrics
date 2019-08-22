class SongSearchResult {
    final SongResultItem songResultItem;

    const SongSearchResult({this.songResultItem});

    static SongSearchResult fromJson(dynamic json) {
      return SongSearchResult(
          songResultItem: SongResultItem.fromJson(json['result']));
    }

}

class SongResultItem {
  final int localID;
  final String title;
  final String lyricsURL;
  final String thumbnailURL;

  const SongResultItem({this.title, this.lyricsURL, this.thumbnailURL, this.localID});

  static SongResultItem fromJson(dynamic json) {
    return SongResultItem(
        title: json['full_title'] as String,
        lyricsURL: json['url'] as String,
        thumbnailURL: json['header_image_thumbnail_url'] as String);
  }
}
