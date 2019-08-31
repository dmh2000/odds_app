import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../models/game_model.dart';

@immutable
abstract class GamesState extends Equatable {
  GamesState([List props = const []]) : super(props);
}

class GamesInitial extends GamesState {}

class GamesLoading extends GamesState {}

class GamesLoaded extends GamesState {
  final Games games;
  final DateTime date;
  GamesLoaded(this.date, this.games) : super([date, games]);
}
