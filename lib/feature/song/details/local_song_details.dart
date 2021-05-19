import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/ui/song_add_edit_screen.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';

class LocalSongDetails extends StatefulWidget {
  final SongBase song;

  LocalSongDetails({this.song});

  @override
  State<StatefulWidget> createState() {
    return LocalSongDetailsState(song);
  }
}

class LocalSongDetailsState extends State<LocalSongDetails> {
  SongBase song;

  late SongAddEditBloc _songAddEditBloc;

  LocalSongDetailsState(this.song);

  @override
  void initState() {
    super.initState();
    _songAddEditBloc = BlocProvider.of<SongAddEditBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SongAddEditBloc, SongAddEditState>(
        bloc: _songAddEditBloc,
        listener: (context, state) {
          if (state is EditSongStateSuccess) {
            setState(() {
              song = state.song;
            });
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.SONG_DETAILS).tr(),
          ),
          body: _getScreenBody(context),
          floatingActionButton: _getFloatingButton(context),
        ));
  }

  Padding _getScreenBody(BuildContext context) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            song.artist,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),
          Text(
            song.title,
            style: Theme.of(context).textTheme.title,
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
          ),
          Text(
            song.lyrics,
            style: Theme.of(context).textTheme.body2,
          )
        ],
      )));

  FloatingActionButton _getFloatingButton(BuildContext context) =>
      FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SongAddScreen(song: song),
            ),
          );
        },
        tooltip: "Edit",
        child: Icon(Icons.edit),
      );
}
