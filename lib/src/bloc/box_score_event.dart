import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BoxScoreEvent extends Equatable {
  BoxScoreEvent([List props = const []]) : super(props);
}

class GetBoxScore extends BoxScoreEvent {
  final int awayId;
  final int homeId;
  GetBoxScore({@required this.awayId, @required this.homeId}) : super();
}

class UpdateBoxScore extends BoxScoreEvent {
  final int awayId;
  final int homeId;
  UpdateBoxScore({@required this.awayId, @required this.homeId}) : super();
}
