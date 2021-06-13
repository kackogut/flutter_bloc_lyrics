import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/details/song_details_screen.dart';
import 'package:flutter_bloc_lyrics/feature/song/search/bloc/songs_search.dart';
import 'package:flutter_bloc_lyrics/model/domain/local_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/network_song.dart';
import 'package:flutter_bloc_lyrics/model/domain/song_base.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';

class SongsSearchList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongsSearchBloc, SongsSearchState>(
      bloc: BlocProvider.of<SongsSearchBloc>(context),
      builder: (BuildContext context, SongsSearchState state) {
        if (state is SearchStateLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SearchStateError) {
          return Text(state.error);
        }
        if (state is SearchStateSuccess) {
          return state.songs.isEmpty
              ? Text(S.EMPTY_LIST.tr())
              : Expanded(
                  child: _SongsSearchResults(
                    songsList: state.songs,
                  ),
                );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(S.ENTER_SONG_TITLE.tr()),
          );
        }
      },
    );
  }
}

class _SongsSearchResults extends StatelessWidget {
  final List<SongBase> songsList;

  const _SongsSearchResults({Key? key, required this.songsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: songsList.length,
      itemBuilder: (BuildContext context, int index) {
        return _SongSearchResultItem(
          song: songsList[index],
        );
      },
    );
  }
}

class _SongSearchResultItem extends StatelessWidget {
  final SongBase song;

  const _SongSearchResultItem({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return song is NetworkSong
        ? _getSongDetailsLayout(context)
        : Dismissible(
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              BlocProvider.of<SongsSearchBloc>(context).add(
                RemoveSong(songID: song.id),
              );
            },
            key: Key(UniqueKey().toString()),
            child: _getSongDetailsLayout(context),
          );
  }

  Padding _getSongDetailsLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: song is LocalSong
            ? Icon(Icons.sd_card)
            : Image.network(
                (song as NetworkSong).albumThumbnail,
              ),
        title: Text(song.title),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SongDetailsScreen(song)),
          );
        },
      ),
    );
  }
}
