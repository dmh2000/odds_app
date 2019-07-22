import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import '../models/box_score_model.dart';
import '../bloc/apikey.dart' as apiKey;

// https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/team_stats_totals.json
const String urlStats = '${apiKey.url}/team_stats_totals.json';
// https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/date/20190721/games.json
const String urlGames = '${apiKey.url}/date';
// https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/games/20190613-CHC-LAD/boxscore.json
const String urlBox = '${apiKey.url}/games';

void getTeams() async {
  String url = urlStats;
  Map<String, String> headers = {
    'Authorization': 'Basic ${apiKey.key}',
  };

  http.Response rsp = await http.get(url, headers: headers);

  if (rsp.statusCode != 200) {
    print(rsp.statusCode);
    print(rsp.reasonPhrase);
    return;
  }
  dynamic obj = convert.json.decode(rsp.body);
  print(obj['teamStatsTotals']);
  /*
  "teamStatsTotals": [
    {
    "team": {
    "id": 140,
    "city": "Arizona",
    "name": "Diamondbacks",
    "abbreviation": "ARI",
    "homeVenue": {
      "id": 108,
      "name": "Chase Field"
    },
    ...
  */

  // extract list of games
  obj['teamStatsTotals'].forEach((dynamic v) {
    var team = v['team'];
    int id = team['id'];
    String city = team['city'];
    String abbr = team['abbreviation'];
    print('$id, $city, $abbr');
  });
}

void getGames() async {
  DateTime date = DateTime.now();
  String month = date.month.toString().padLeft(2, '0');
  String day = (date.day - 1).toString().padLeft(2, '0');

  String url = '$urlGames/2019$month$day/games.json';

  Map<String, String> headers = {
    'Authorization': 'Basic ${apiKey.key}',
  };

  http.Response rsp = await http.get(url, headers: headers);

  if (rsp.statusCode != 200) {
    print(rsp.statusCode);
    print(rsp.reasonPhrase);
    return;
  }

  dynamic obj = convert.json.decode(rsp.body);
  dynamic games = obj['games'];
  games.forEach((game) {
    var sched = game['schedule'];
    var away = sched['awayTeam'];
    var home = sched['homeTeam'];
    print('${away['abbreviation']} ${home['abbreviation']}');
  });
}

Future<BoxScoreModel> getBoxScore(
    DateTime date, String away, String home) async {
  // extract date to compose URL
  String month = date.month.toString().padLeft(2, '0');
  String day = (date.day - 1).toString().padLeft(2, '0');
  String url = '$urlBox/2019$month$day-$away-$home/boxscore.json';

  // authorize
  Map<String, String> headers = {
    'Authorization': 'Basic ${apiKey.key}',
  };

  // make request
  http.Response rsp = await http.get(url, headers: headers);

  if (rsp.statusCode != 200) {
    print(rsp.statusCode);
    print(rsp.reasonPhrase);
    return null;
  }

  // parse request
  var obj;
  try {
    obj = convert.json.decode(rsp.body);
  } catch (e) {
    return BoxScoreModel.empty();
  }

  // populate box score model
  var scoring = obj['scoring'];
  var game = obj['game'];

  int awayTeam = game['awayTeam']['id'];
  int homeTeam = game['homeTeam']['id'];

  int awayRuns = scoring['awayScoreTotal'];
  int awayHits = scoring['awayHitsTotal'];
  int awayErrs = scoring['awayErrorsTotal'];

  int homeRuns = scoring['homeScoreTotal'];
  int homeHits = scoring['homeHitsTotal'];
  int homeErrs = scoring['homeErrorsTotal'];

  int inning = scoring['currentInning'] ?? scoring['innings'].length;
  return BoxScoreModel(
    awayTeam,
    homeTeam,
    awayRuns,
    awayHits,
    awayErrs,
    homeRuns,
    homeHits,
    homeErrs,
    inning,
  );
}

main() {
  // getTeams();
  getGames();
  Future<BoxScoreModel> boxScore = getBoxScore(DateTime.now(), 'BOS', 'BAL');

  if (boxScore != null) {
    boxScore.then((v) {
      print(v);
    });
  }
}
