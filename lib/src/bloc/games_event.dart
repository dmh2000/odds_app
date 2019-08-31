import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class GamesEvent extends Equatable {
  GamesEvent([List props = const []]) : super(props);
}

class GetGames extends GamesEvent {
  final DateTime day;
  GetGames({@required this.day}) : super();

  @override
  String toString() {
    return day.toLocal().toString();
  }
}
