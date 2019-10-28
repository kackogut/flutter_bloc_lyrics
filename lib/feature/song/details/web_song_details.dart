import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebSongDetails extends StatelessWidget {
  final String songDetailsURL;

  WebSongDetails({this.songDetailsURL});

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: songDetailsURL,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).tr(S.SONG_LYRICS)),
      ),
    );
  }
}
