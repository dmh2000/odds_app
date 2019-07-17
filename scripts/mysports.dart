import 'package:http/http.dart' as http;
import 'dart:io' as io;
import 'dart:convert' as convert;

String teamStatsUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/team_stats_totals.json';

String gameDataUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date';

String venueUrl =
    'https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/venues.json';

getTeamStats() async {
  String apikey = io.Platform.environment['mysports.apikey'];

  Map<String, String> headers = {
    'Authorization': 'Basic $apikey',
  };

  http.Response rsp = await http.get(teamStatsUrl, headers: headers);

  dynamic js = convert.json.decode(rsp.body);

  js['teamStatsTotals'].forEach((v) {
    print('${v['team']['name']} : ${v['team']['id']}');
  });
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

  js['games'].forEach((v) {
    var sched = v['schedule'];
    int id = sched['id'];
    int homeId = sched['homeTeam']['id'];
    int awayId = sched['awayTeam']['id'];
    DateTime startTime = DateTime.parse(sched['startTime']).toLocal();
    String hour = startTime.hour.toString().padLeft(2, '0');
    String minute = startTime.minute.toString().padLeft(2, '0');
    String status = sched['playedStatus'];
    int venue = sched['venue']['id'];

    print('$id,$homeId,$awayId,$hour:$minute,$status,$venue');
  });
}

getVenues() async {
  String apikey = io.Platform.environment['mysports.apikey'];

  Map<String, String> headers = {
    'Authorization': 'Basic $apikey',
  };

  http.Response rsp = await http.get(venueUrl, headers: headers);

  dynamic js = convert.json.decode(rsp.body);

  js['venues'].forEach((v) {
    int id = v['venue']['id'];
    String name = v['venue']['name'];
    String city = v['venue']['city'];
    String country = v['venue']['country'];
    print('int venue = $id; // $name,$city,$country,TZ');
  });
}

main() {
  // getTeamStats();
  getTodaysGames();
  // etVenues();
}
