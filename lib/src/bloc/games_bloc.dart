import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../models/models.dart' as models;
import 'apikey.dart' as apiKey;

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  @override
  GamesState get initialState => GamesInitial();

  @override
  Stream<GamesState> mapEventToState(
    GamesEvent event,
  ) async* {
    if (event is GetGames) {
      // notifiy loading
      yield GamesLoading();

      // request game data from server
      final http.Response rsp = await _getTodaysGames();

      // convert response to game model
      dynamic js = convert.json.decode(rsp.body);
      models.Games games = models.Games.fromJson(js);

      // games are loaded
      yield GamesLoaded(games);
    }
  }

  Future<http.Response> _getTodaysGames() {
    // construct the URL for todays games
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = now.month.toString().padLeft(2, '0');
    String day = now.day.toString().padLeft(2, '0');
    String url = '${apiKey.url}/$year$month$day/games.json';

    Map<String, String> headers = {
      'Authorization': 'Basic ${apiKey.key}',
    };

    return http.get(url, headers: headers);
  }
}
