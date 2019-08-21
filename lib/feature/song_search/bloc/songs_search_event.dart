import 'package:equatable/equatable.dart';

abstract class SongSearchEvent extends Equatable {
  SongSearchEvent([List props = const []]) : super(props);
}

class TextChanged extends SongSearchEvent {
  final String query;

  TextChanged({this.query}) : super([query]);

  @override
  String toString() => "SongSearchTextChanged { query: $query }";

}