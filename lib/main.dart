import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/ui/search_screen.dart';
import 'package:flutter_bloc_lyrics/repository/local_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

import 'feature/song/search/bloc/songs_search_bloc.dart';

void main() {
  final LyricsRepository _lyricsRepository =
      LyricsRepository(LyricsClient(), LocalClient());

  runApp(EasyLocalization(
      path: 'assets/translations',
      supportedLocales: [Locale('en', 'US')],
      child: LyricsApp(lyricsRepository: _lyricsRepository)));
}

class LyricsApp extends StatelessWidget {
  final LyricsRepository lyricsRepository;

  const LyricsApp({Key key, @required this.lyricsRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SongAddEditBloc>(
            create: (context) =>
                SongAddEditBloc(lyricsRepository: lyricsRepository),
          ),
          BlocProvider<SongsSearchBloc>(
            create: (context) => SongsSearchBloc(
                lyricsRepository: lyricsRepository,
                songAddEditBloc: BlocProvider.of<SongAddEditBloc>(context)),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(primaryColor: Colors.blue),
            home: SearchScreen()));
  }
}
