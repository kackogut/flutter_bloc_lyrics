import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

class LocalSongDetails extends StatelessWidget {
  final SongBase song;

  LocalSongDetails({this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Song details"),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Text(
                  song.artist,
                  style: Theme.of(context).textTheme.title,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Text(
                  song.title,
                  style: Theme.of(context).textTheme.headline,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.0),
                ),
                Text(
                  song.lyrics,
                  style: Theme.of(context).textTheme.body2,
                )
              ],
            ))));
  }
}
