import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/repository/local_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

import 'feature/song/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/search_screen.dart';

void main() {
  final LyricsRepository _lyricsRepository = LyricsRepository(LyricsClient(), LocalClient());

  runApp(LyricsApp(lyricsRepository: _lyricsRepository));
}

class LyricsApp extends StatelessWidget {
  final LyricsRepository lyricsRepository;

  const LyricsApp({Key key, @required this.lyricsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (context) =>
            SongsSearchBloc(lyricsRepository: lyricsRepository),
        child: MaterialApp(
            theme: ThemeData(primaryColor: Colors.blue), home: SearchScreen()));
  }
}
