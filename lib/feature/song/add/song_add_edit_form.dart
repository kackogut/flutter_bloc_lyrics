import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_event.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/widgets/buttons.dart';

class SongAddForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SongAddState();
  }
}

class SongAddState extends State<SongAddForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _lyrics;
  String _artist;
  String _title;

  SongsSearchBloc _songSearchBloc;

  @override
  void initState() {
    super.initState();
    _songSearchBloc = BlocProvider.of<SongsSearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return
      BlocListener<SongsSearchBloc, SongsSearchState>(
    bloc: _songSearchBloc,
    listener: (context, state){
      if(state is AddSongStateSuccess){
        Navigator.pop(context);
      }
    },
    child:  Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(hintText: "Title"),
                  onSaved: (value) => _title = value,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? "Empty title"
                        : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Artist"),
                  onSaved: (value) => _artist = value,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? "Empty Artist"
                        : null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: "Lyrics"),
                  onSaved: (value) => _lyrics = value,
                  validator: (val) {
                    return val.trim().isEmpty
                        ? "Empty lyrics"
                        : null;
                  },
                  minLines: 15,
                  maxLines: 15,
                ),
                Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: getBaseButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            _songSearchBloc.dispatch(AddSong(
                                song: SongBase(
                                    title: _title,
                                    lyrics: _lyrics,
                                    artist: _artist)));
                          }},
                        text: "Add song"))
              ],
            ))));
  }
}
