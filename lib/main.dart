import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_client.dart';
import 'package:flutter_bloc_lyrics/repository/lyrics_repository.dart';

import 'feature/song_search/bloc/songs_search_bloc.dart';
import 'feature/song_search/ui/search_screen.dart';

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
      title: 'Lyrics App',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Lyrics App"),
        ),
        body: BlocProvider(
          builder: (context) =>
              SongsSearchBloc(lyricsRepository: lyricsRepository),
          child: SearchScreen(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
