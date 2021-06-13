class Artist {
  final String name;

  const Artist({required this.name});

  static Artist fromJson(dynamic json) {
    return Artist(name: json['name'] as String);
  }
}
