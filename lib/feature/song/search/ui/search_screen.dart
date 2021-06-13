import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/ui/song_add_edit_screen.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/search_bar.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/songs_search_list.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.APP_NAME.tr()),
      ),
      body: Column(
        children: <Widget>[SearchBar(), SongsSearchList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SongAddScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
