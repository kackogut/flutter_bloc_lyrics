import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/bloc/songs_search_state.dart';
import 'package:flutter_bloc_lyrics/feature/song/details/song_details_screen.dart';
import 'package:flutter_bloc_lyrics/model/api/song_result.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';

class SongsSearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongsSearchBloc, SongsSearchState>(
      bloc: BlocProvider.of<SongsSearchBloc>(context),
      builder: (BuildContext context, SongsSearchState state) {
        if (state is SearchStateEmpty) {
          return Text('Enter song title');
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.songs.isEmpty
              ? Text("No items")
              : Expanded(
                  child: _SongsSearchResults(
                    songsList: state.songs,
                  ),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

class _SongsSearchResults extends StatelessWidget {
  final List<SongBase> songsList;

  const _SongsSearchResults({Key key, @required this.songsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: songsList.length,
        itemBuilder: (BuildContext context, int index) {
          return _SongSearchResultItem(
            song: songsList[index],
          );
        });
  }
}

class _SongSearchResultItem extends StatelessWidget {
  final SongBase song;

  const _SongSearchResultItem({Key key, this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: song.albumThumbnail == null ? Icon(Icons.sd_card) : Image.network(
            song.albumThumbnail,
          ),
          title: Text(song.title),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SongDetailsScreen(song.lyricsURL)));
          },
        ));
  }
}