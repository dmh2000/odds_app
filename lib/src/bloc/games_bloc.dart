import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart' as bloc;
import './bloc.dart';
import '../models/models.dart' as models;
import 'apikey.dart' as apiKey;

class GamesBloc extends bloc.Bloc<GamesEvent, GamesState> {
  DateTime gameDay = DateTime.now();

  @override
  GamesState get initialState {
    return GamesInitial();
  }

  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    if (event is GetGames) {
      // notifiy loading
      yield GamesLoading();

      // request game data from server
      final http.Response rsp = await _getGames(event.day);

      // quit if not status 200
      if (rsp.statusCode != 200) {
        yield GamesLoaded(event.day, models.Games(games: []));
      } else {
        // load the sames object
        models.Games games = models.Games.fromJson(rsp.body);

        // games are loaded
        yield GamesLoaded(event.day, games);
      }
    }
  }

  Future<http.Response> _getGames(day) {
    DateTime gameDay = day;
    String season = 'current';
    // construct the URL for games
    if (gameDay.month >= 10) {
      season = '${gameDay.year}-playoff';
    } else {
      season = '${gameDay.year}-regular';
    }
    String dayArg =
        '${day.year}${day.month.toString().padLeft(2, '0')}${day.day.toString().padLeft(2, '0')}';
    String url = '${apiKey.url}/$season/date/$dayArg/games.json';
    print(url);
    Map<String, String> headers = {
      'Authorization': 'Basic ${apiKey.key}',
    };

    return http.get(url, headers: headers);
  }
}
