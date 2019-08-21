import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song_search/ui/search_bar.dart';
import 'package:flutter_bloc_lyrics/feature/song_search/ui/songs_search_list.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SearchBar(), SongsSearchList()],
    );
  }

}