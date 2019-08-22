import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

import 'feature/song/bloc/songs_search_bloc.dart';
import 'feature/song/search/ui/search_screen.dart';

void main() {
  final LyricsRepository _lyricsRepository = LyricsRepository(LyricsClient());

  runApp(LyricsApp(lyricsRepository: _lyricsRepository));
}

class LyricsApp extends StatelessWidget {
  final LyricsRepository lyricsRepository;

  const LyricsApp({Key key, @required this.lyricsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: BlocProvider(
            builder: (context) =>
                SongsSearchBloc(lyricsRepository: lyricsRepository),
            child: SearchScreen()));
  }
}
