import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/game_model.dart';

@immutable
abstract class BoxScoreEvent extends Equatable {
  BoxScoreEvent([List props = const []]) : super(props);
}

class GetBoxScore extends BoxScoreEvent {
  final Game game;
  GetBoxScore({@required this.game}) : super();
}

class UpdateBoxScore extends BoxScoreEvent {
  final Game game;
  UpdateBoxScore({@required this.game}) : super();
}
