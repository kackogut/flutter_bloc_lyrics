import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/details/web_song_details.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/network_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';

import 'local_song_details.dart';

class SongDetailsScreen extends StatelessWidget {
  final SongBase song;

  SongDetailsScreen(this.song);

  @override
  Widget build(BuildContext context) {
    return song is LocalSong
        ? LocalSongDetails(song: song as LocalSong)
        : WebSongDetails(songDetailsURL: (song as NetworkSong).lyricsURL);
  }
}
