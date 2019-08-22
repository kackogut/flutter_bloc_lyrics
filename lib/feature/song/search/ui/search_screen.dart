import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/search_bar.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/songs_search_list.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyrics App',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Lyrics App"),
          ),
          body:Column(
            children: <Widget>[
              SearchBar(), SongsSearchList()],
          ),
          floatingActionButton: FloatingActionButton(onPressed: null, child: Icon(Icons.add),),
      ),
    );
  }

}