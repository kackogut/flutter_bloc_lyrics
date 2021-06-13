import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/ui/song_add_edit_screen.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';

class LocalSongDetails extends StatefulWidget {
  final LocalSong song;

  LocalSongDetails({required this.song});

  @override
  State<StatefulWidget> createState() {
    return LocalSongDetailsState(song);
  }
}

class LocalSongDetailsState extends State<LocalSongDetails> {
  LocalSong song;

  late SongAddEditBloc _songAddEditBloc;

  LocalSongDetailsState(this.song);

  @override
  void initState() {
    super.initState();
    _songAddEditBloc = BlocProvider.of<SongAddEditBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Change to BlocBuilder
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
      ),
    );
  }

  Padding _getScreenBody(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Text(
                song.artist,
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
              ),
              Text(
                song.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
              ),
              Text(
                song.lyrics,
                style: Theme.of(context).textTheme.bodyText1,
              )
            ],
          ),
        ),
      );

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
        tooltip: S.EDIT.tr(),
        child: Icon(Icons.edit),
      );
}
