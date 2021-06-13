import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

class LocalSong extends SongBase {
  final String lyrics;

  LocalSong({
    required this.lyrics,
    required id,
    required title,
    required artist,
  }) : super(id: id, title: title, artist: artist);

  LocalSong copyWith({
    String? lyrics,
    int? id,
    String? title,
    String? artist,
  }) =>
      LocalSong(
        lyrics: lyrics ?? this.lyrics,
        id: id ?? this.id,
        title: title ?? this.title,
        artist: artist ?? this.artist,
      );
}
