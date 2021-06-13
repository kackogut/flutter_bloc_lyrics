abstract class SongBase {
  final int id;
  final String title;
  final String artist;

  const SongBase({
    required this.id,
    required this.title,
    required this.artist,
  });

  bool isInQuery(String query) {
    return (title.toLowerCase().contains(query.toLowerCase()) ||
        artist.toLowerCase().contains(query.toLowerCase()));
  }
}
