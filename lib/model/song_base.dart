class SongBase {
  final String title;
  final String artist;
  final String? lyrics;
  final String? lyricsURL;
  final String? albumThumbnail;
  final int? id;

  const SongBase({
    required this.title,
    required this.artist,
    this.lyrics,
    this.lyricsURL,
    this.albumThumbnail,
    this.id,
  });

  bool isInQuery(String query) {
    return (title.toLowerCase().contains(query.toLowerCase()) ||
        artist.toLowerCase().contains(query.toLowerCase()));
  }

  SongBase copyWith({title, artist, lyrics, lyricsURL, albumThumbnail, id}) =>
      SongBase(
        title: title ?? this.title,
        artist: artist ?? this.artist,
        lyrics: lyrics ?? this.lyrics,
        lyricsURL: lyricsURL ?? this.lyricsURL,
        albumThumbnail: albumThumbnail ?? this.albumThumbnail,
        id: id ?? this.id,
      );
}
