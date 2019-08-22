
import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/song_add_form.dart';
import 'package:flutter_bloc_lyrics/widgets/buttons.dart';

class SongAddScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add song"),
      ),
      body: Column(
        children: <Widget>[
          SongAddForm(),
        ],
      ),
    );
  }
}
