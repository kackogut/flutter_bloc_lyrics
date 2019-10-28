import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/ui/song_add_edit_screen.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/search_bar.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/songs_search_list.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lyrics App"),
        ),
        body: Column(
          children: <Widget>[SearchBar(), SongsSearchList()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SongAddScreen()));
          },
          child: Icon(Icons.add),
        ),
    );
  }
}
