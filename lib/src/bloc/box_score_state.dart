import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/models.dart' as models;

@immutable
abstract class BoxScoreState extends Equatable {
  BoxScoreState([List props = const []]) : super(props);
}

class BoxScoreInitial extends BoxScoreState {}

class BoxScoreLoading extends BoxScoreState {}

class BoxScoreLoaded extends BoxScoreState {
  final models.BoxScoreModel boxScore;

  BoxScoreLoaded(this.boxScore) : super([boxScore]);
}
