import 'dart:convert' as convert;
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Game extends Equatable {
  final int gameId;
  final int homeId;
  final int awayId;
  final String venue;
  final DateTime startTime;
  final String playedStatus;

  Game(this.gameId, this.homeId, this.awayId, this.venue, this.startTime,
      this.playedStatus)
      : super([gameId, homeId, awayId, venue, startTime, playedStatus]);

  String toString() {
    return '$gameId:$homeId:$awayId:$venue:$startTime:$playedStatus';
  }
}

@immutable
class Games extends Equatable {
  final List<Game> games;

  Games({@required this.games}) : super([games]);

  factory Games.fromJson(String json) {
    List<Game> g;

    // convert response to game model
    dynamic obj = convert.json.decode(json);

    // extract list of games
    List<dynamic> d = obj['games'].map((dynamic v) {
      var sched = v['schedule'];
      int id = sched['id'];
      int homeId = sched['homeTeam']['id'];
      int awayId = sched['awayTeam']['id'];
      DateTime startTime = DateTime.parse(sched['startTime']).toLocal();
      String status = sched['playedStatus'];
      String venue = sched['venue']['name'];

      // print('$id,$homeId,$awayId,$hour:$minute,$status,$venueId,$status');
      return Game(id, homeId, awayId, venue, startTime, status);
    }).toList();

    // convert to list of games
    g = List<Game>.from(d);

    return Games(games: g);
  }

  bool isEmpty() {
    return games.length == 0;
  }

  Game getGameById(int id) {
    // find first game that has the specified id
    return games.firstWhere(
      (game) {
        return (game.gameId == id);
      },
      orElse: () => null,
    );
  }

  Game getGameByTeam(int teamId) {
    // find first record where either home or away matches teamId
    return games.firstWhere(
      (game) {
        return (game.homeId == teamId) || (game.awayId == teamId);
      },
      orElse: () => null,
    );
  }
}
