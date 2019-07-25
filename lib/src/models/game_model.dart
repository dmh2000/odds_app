import 'dart:convert' as convert;
import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Game extends Equatable {
  final int gameId;
  final int homeId;
  final int awayId;
  final String venue;
  final DateTime startTime;
  final String playedStatus;
  final String awayAbbr;
  final String homeAbbr;
  int hdr;

  Game(this.gameId, this.homeId, this.awayId, this.venue, this.startTime,
      this.playedStatus, this.awayAbbr, this.homeAbbr)
      : hdr = 0,
        super([gameId, startTime]); // equatable uses these two for equality

  String toString() {
    return '$gameId:$homeId:$awayId:$venue:$startTime:$playedStatus,$awayAbbr,$homeAbbr,$hdr';
  }

  String get timeString {
    // change 24 hour time to local AM/PM time
    DateTime localTime = startTime.toLocal();
    int hour24 = localTime.hour;
    int minute24 = localTime.minute;
    String hour;
    String minute;
    String ampm;
    if (hour24 > 12) {
      hour24 -= 12;
      ampm = 'PM';
    } else if (hour24 == 12) {
      ampm = 'PM';
    } else {
      ampm = 'AM';
    }

    hour = hour24.toString().padLeft(2);
    minute = minute24.toString().padLeft(2, '0');

    return '$hour:$minute $ampm';
  }

  String get urlSuffix {
    String suffix = '';
    switch (hdr) {
      case 0:
        suffix = '$awayAbbr-$homeAbbr';
        break;
      case 1:
        suffix = '$awayAbbr-$homeAbbr-1';
        break;
      case 2:
        suffix = '$awayAbbr-$homeAbbr-2';
        break;
      default:
        throw new Exception('no triple headers allowed!');
        break;
    }
    return suffix;
  }
}

@immutable
class Games extends Equatable {
  final List<Game> games;

  Games({@required this.games}) : super([games]) {
    // update the double headers in the list
    updateDoubleHeaders();
  }

  // process the json data and create Games object
  factory Games.fromJson(String json) {
    List<Game> g;

    // get current time to identify 'today'
    DateTime now = DateTime.now();

    // convert response to game model
    dynamic obj = convert.json.decode(json);

    // extract list of games
    List<dynamic> d = obj['games'].map((dynamic v) {
      var sched = v['schedule'];
      int id = sched['id'];
      int homeId = sched['homeTeam']['id'];
      int awayId = sched['awayTeam']['id'];
      DateTime startTime = DateTime.parse(sched['startTime']);
      String status = sched['playedStatus'];
      String venue = sched['venue']['name'];
      String awayAbbr = sched['awayTeam']['abbreviation'];
      String homeAbbr = sched['homeTeam']['abbreviation'];

      // print('$id,$homeId,$awayId,$hour:$minute,$status,$venueId,$status');
      return Game(
          id, homeId, awayId, venue, startTime, status, awayAbbr, homeAbbr);
    }).toList(); // turn it into a list

    // convert to list of games
    g = List<Game>.from(d);

    // keep only games that are played today
    g = g.where((v) {
      return now.day == v.startTime.day;
    }).toList();

    // invoke default constructor
    return Games(games: g);
  }

  void updateDoubleHeaders() {
    HashMap<String, Game> hmap = HashMap<String, Game>();

    games.forEach((b) {
      String key = b.awayAbbr;
      print(key);
      // is there a duplicate already in the hash map
      if (hmap.containsKey(key)) {
        // the one already in the map gets hdr = 1
        // the new one gets hedr = 2
        Game a = hmap[key];
        a.hdr = 1;
        b.hdr = 2;
      } else {
        // not already in hash map, add it
        hmap[key] = b;
      }
    });
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
