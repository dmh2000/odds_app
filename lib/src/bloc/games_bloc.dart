import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart' as bloc;
import './bloc.dart';
import '../models/models.dart' as models;
import 'apikey.dart' as apiKey;

class GamesBloc extends bloc.Bloc<GamesEvent, GamesState> {
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
      print('loading');
      yield GamesLoading();

      // request game data from server
      final http.Response rsp = await _getGames(event.day);
      print('games');

      // quit if not status 200
      if (rsp.statusCode != 200) {
        print('empty');
        yield GamesLoaded(models.Games(games: []));
      } else {
        print('loaded');
        // load the sames object
        models.Games games = models.Games.fromJson(rsp.body);

        // games are loaded
        yield GamesLoaded(games);
      }
    }
  }

  Future<http.Response> _getGames(day) {
    // construct the URL for todays games
    String dayArg =
        '${day.year}${day.month.toString().padLeft(2, '0')}${day.day.toString().padLeft(2, '0')}';
    String url = '${apiKey.url}/date/$dayArg/games.json';
    // String url = '${apiKey.url}/games.json?date=tomorrow';
    print(url);
    Map<String, String> headers = {
      'Authorization': 'Basic ${apiKey.key}',
    };

    return http.get(url, headers: headers);
  }
}
