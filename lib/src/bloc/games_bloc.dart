import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../models/models.dart' as models;
import 'apikey.dart' as apiKey;

class GamesBloc extends Bloc<GamesEvent, GamesState> {
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
      final http.Response rsp = await _getTodaysGames();

      // quit if not status 200
      if (rsp.statusCode != 200) {
        yield GamesLoaded(models.Games(games: []));
      } else {
        // load the sames object
        models.Games games = models.Games.fromJson(rsp.body);

        // games are loaded
        yield GamesLoaded(games);
      }
    }
  }

  Future<http.Response> _getTodaysGames() {
    // construct the URL for todays games
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String url = '${apiKey.url}/games.json?date=today';

    Map<String, String> headers = {
      'Authorization': 'Basic ${apiKey.key}',
    };

    print(url);

    return http.get(url, headers: headers);
  }
}
