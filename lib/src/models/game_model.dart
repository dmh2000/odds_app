import 'dart:convert' as convert;
import 'dart:collection';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Game extends Equatable {
  final int gameId;
  final int homeId;
  final int awayId;
  final String venue;
  final DateTime startTime; // time is Local
  final String playedStatus;
  final String awayAbbr;
  final String homeAbbr;
  final int hdr;

  Game(
      {this.gameId,
      this.homeId,
      this.awayId,
      this.venue,
      this.startTime,
      this.playedStatus,
      this.awayAbbr,
      this.homeAbbr,
      this.hdr})
      : super([gameId, startTime]); // equatable uses these two for equality

  String toString() {
    return '$gameId:$homeId:$awayId:$venue:$startTime:$playedStatus,$awayAbbr,$homeAbbr,$hdr';
  }

  String get timeString {
    // change 24 hour time to local AM/PM time
    DateTime localTime = startTime;
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

// temporary class to hold game data so the Game can be immutable
class GameT {
  int gameId;
  int homeId;
  int awayId;
  String venue;
  DateTime startTime;
  String playedStatus;
  String awayAbbr;
  String homeAbbr;
  int hdr;

  GameT(this.gameId, this.homeId, this.awayId, this.venue, this.startTime,
      this.playedStatus, this.awayAbbr, this.homeAbbr)
      : hdr = 0;
}

@immutable
class Games extends Equatable {
  final List<Game> games;

  Games({@required this.games}) : super([games]);

  // process the json data and create Games object
  factory Games.fromJson(String json) {
    // convert response to game model
    dynamic obj = convert.json.decode(json);

    // convert json to list of GameT's
    List<GameT> gt = parseJson(obj);

    // keep only games that are played today
    // get current LOCAL time to identify 'today'
    // maybe not necessary now that times are all local
    DateTime now = DateTime.now(); // local time
    gt = gt.where((v) {
      return now.day == v.startTime.day; // local time
    }).toList();

    // update the hdr field
    gt = updateDoubleHeaders(gt);

    // now create a List<Game> that is immutable
    // Game({this.gameId, this.homeId, this.awayId, this.venue, this.startTime,
    //this.playedStatus, this.awayAbbr, this.homeAbbr,this.hdr})
    List<Game> games = gt.map((v) {
      return Game(
          gameId: v.gameId,
          homeId: v.homeId,
          awayId: v.awayId,
          venue: v.venue,
          startTime: v.startTime,
          playedStatus: v.playedStatus,
          awayAbbr: v.awayAbbr,
          homeAbbr: v.homeAbbr,
          hdr: v.hdr);
    }).toList();

    // invoke default constructor
    return Games(games: games);
  }

  static List<GameT> parseJson(js) {
    // extract list of games
    List<dynamic> d = js['games'].map((dynamic v) {
      var sched = v['schedule'];
      int id = sched['id'];
      int homeId = sched['homeTeam']['id'];
      int awayId = sched['awayTeam']['id'];
      DateTime startTime = DateTime.parse(sched['startTime']).toLocal();
      String status = sched['playedStatus'];
      String venue = sched['venue']['name'];
      String awayAbbr = sched['awayTeam']['abbreviation'];
      String homeAbbr = sched['homeTeam']['abbreviation'];

      return GameT(
          id, homeId, awayId, venue, startTime, status, awayAbbr, homeAbbr);
    }).toList(); // turn it into a list

    // convert to list of GameTs
    List<GameT> gt = List<GameT>.from(d);

    return gt;
  }

  static List<GameT> updateDoubleHeaders(List<GameT> gt) {
    HashMap<String, GameT> hmap = HashMap<String, GameT>();

    gt.forEach((b) {
      String key = b.awayAbbr;
      // is there a duplicate already in the hash map
      if (hmap.containsKey(key)) {
        // the one already in the map gets hdr = 1
        // the new one gets hedr = 2
        GameT a = hmap[key];
        a.hdr = 1;
        b.hdr = 2;
      } else {
        // not already in hash map, add it
        hmap[key] = b;
      }
    });

    return gt;
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
