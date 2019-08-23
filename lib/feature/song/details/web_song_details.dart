import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebSongDetails extends StatelessWidget {

  final String songDetailsURL;

  WebSongDetails({this.songDetailsURL});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: songDetailsURL,
      appBar: AppBar(
        title: Text("Song lyrics"),
      ),
    );
  }

}