import 'dart:collection';

import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'dart:convert' as convert;

String teamStatsUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/team_stats_totals.json';

String gameDataUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date';

String venueUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/venues.json';

class Game {
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
      this.playedStatus, this.awayAbbr, this.homeAbbr, this.hdr);

  String toString() {
    return '$gameId:$homeId:$awayId:$venue:$startTime:$playedStatus,$awayAbbr,$homeAbbr,$hdr';
  }
}

getTodaysGames() async {
  String apikey = io.Platform.environment['mysports.apikey'];

  DateTime now = DateTime.now();
  String year = now.year.toString();
  String month = now.month.toString().padLeft(2, '0');
  String day = now.day.toString().padLeft(2, '0');
  String url = '$gameDataUrl/$year$month$day/games.json';

  Map<String, String> headers = {
    'Authorization': 'Basic $apikey',
  };

  http.Response rsp = await http.get(url, headers: headers);

  dynamic js = convert.json.decode(rsp.body);

  List<Game> games = js['games']
      .map((g) {
        var sched = g['schedule'];
        int id = sched['id'];
        int homeId = sched['homeTeam']['id'];
        int awayId = sched['awayTeam']['id'];
        DateTime startTime = DateTime.parse(sched['startTime']);
        String status = sched['playedStatus'];

        String awayAbbr = sched['homeTeam']['abbreviation'];
        String homeAbbr = sched['awayTeam']['abbreviation'];
        String venue = sched['venue']['name'];

        return Game(id, homeId, awayId, venue, startTime, status, awayAbbr,
            homeAbbr, 0);
      })
      .toList()
      .cast<Game>();

  return games;
}

List<Game> updateDoubleHeaders(List<Game> games) {
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

  return games;
}

main() async {
  List<Game> games = await getTodaysGames();

  games = updateDoubleHeaders(games);

  games.forEach((game) {
    print(game.toString());
  });
}
