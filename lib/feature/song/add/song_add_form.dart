import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';
import 'package:flutter_bloc_lyrics/widgets/buttons.dart';

class SongAddForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return SongAddState();
  }
}

class SongAddState extends State<SongAddForm>{
  final _songAddTitleController = TextEditingController();
  final _songAddArtistController = TextEditingController();
  final _songLoyricsController = TextEditingController();

  SongsSearchBloc _songSearchBloc;

  @override
  void initState() {
    super.initState();
    _songSearchBloc = BlocProvider.of<SongsSearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _songAddTitleController,
              decoration: InputDecoration(hintText: "Title"),
            ),
            TextField(
              controller: _songAddArtistController,
              decoration: InputDecoration(hintText: "Artist"),
            ),
        TextField(
          controller: _songLoyricsController,
          decoration: InputDecoration(hintText: "Lyrics"),
          minLines: 15,
          maxLines: 15,
        ),
            getBaseButton(
                onPressed: () {
                  _songSearchBloc.dispatch(AddSong(
                      song: SongResultItem(
                        title: _songAddTitleController.text + " by " + _songAddArtistController.text,
                      )));
                  Navigator.pop(context);
                },
                text: "Add song")
          ],
        ));
  }

  @override
  void dispose() {
    _songAddTitleController.dispose();
    _songAddArtistController.dispose();
    super.dispose();
  }

}
