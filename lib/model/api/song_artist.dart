import 'package:flutter_bloc_lyrics/model/song_base.dart';

class Artist {
  final String name;

  const Artist({required this.name});

  static Artist fromJson(dynamic json) {
    return Artist(
        name: json['name'] as String);
        }
}
