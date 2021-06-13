import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

class NetworkSong extends SongBase {
  final String lyricsURL;
  final String albumThumbnail;

  const NetworkSong({
    required this.lyricsURL,
    required this.albumThumbnail,
    id,
    title,
    artist
  }) : super(id: id, title: title, artist: artist);
}
