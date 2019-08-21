import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song_search/bloc/songs_search_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song_search/bloc/songs_search_event.dart';

class SearchBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchBarState();

}

class _SearchBarState extends State<SearchBar>{
  final _songSearchController = TextEditingController();
  SongsSearchBloc _songSearchBloc;


  @override
  void initState() {
    super.initState();
    _songSearchBloc = BlocProvider.of<SongsSearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _songSearchController,
      onChanged: (text) {
        _songSearchBloc.dispatch(TextChanged(query: text));
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search..."
      ),
    );
  }

  @override
  void dispose() {
    _songSearchController.dispose();
    super.dispose();
  }


}