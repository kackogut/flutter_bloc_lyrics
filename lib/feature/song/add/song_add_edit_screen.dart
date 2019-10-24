import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/song_add_edit_form.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

class SongAddScreen extends StatelessWidget {
  final SongBase song;

  SongAddScreen({this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add song"),
      ),
      body: Column(
        children: <Widget>[
          SongAddForm(song: song),
        ],
      ),
    );
  }
}
