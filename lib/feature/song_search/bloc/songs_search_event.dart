import 'package:equatable/equatable.dart';

abstract class SongSearchEvent extends Equatable {
  SongSearchEvent([List props = const []]) : super(props);
}

class SongSearchTextChanged extends SongSearchEvent {
  final String query;

  SongSearchTextChanged({this.query}) : super([query]);

  @override
  String toString() => "SongSearchTextChanged { query: $query }";

}