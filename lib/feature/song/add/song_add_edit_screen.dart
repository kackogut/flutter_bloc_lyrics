import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/feature/song/add/song_add_edit_form.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';

class SongAddScreen extends StatelessWidget {
  final SongBase song;

  SongAddScreen({this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr(S.ADD_SONG)),
      ),
      body: Column(
        children: <Widget>[
          SongAddForm(song: song),
        ],
      ),
    );
  }
}
