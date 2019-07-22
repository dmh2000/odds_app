import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart' as bloc;
import './bloc.dart';
import '../models/models.dart' as models;
import 'apikey.dart' as apiKey;

class BoxScoreBloc extends bloc.Bloc<BoxScoreEvent, BoxScoreState> {
  @override
  BoxScoreState get initialState {
    return BoxScoreInitial();
  }

  @override
  Stream<BoxScoreState> mapEventToState(
    BoxScoreEvent event,
  ) async* {
    if (event is GetBoxScore) {
      // notifiy loading
      yield BoxScoreLoading();

      // request game data from server
      final http.Response rsp = await _getBoxScore(event.awayId, event.homeId);

      // quit if not status 200
      if (rsp.statusCode != 200) {
        yield BoxScoreLoaded(models.BoxScoreModel.empty());
      } else {
        // load the sames object
        models.BoxScoreModel boxScore = models.BoxScoreModel.fromJSON(rsp.body);

        // BoxScore are loaded
        yield BoxScoreLoaded(boxScore);
      }
    }
  }

  Future<http.Response> _getBoxScore(int away, int home) {
    // construct the URL for todays games
    // https://api.mysportsfeeds.com/v2.1/pull/mlb/2019-regular/games/20190613-CHC-LAD/boxscore.xml
    String url = '${apiKey.url}/games';
    String awayAbbr = '';
    String homeAbbr = '';

    DateTime date = DateTime.now();
    String month = date.month.toString().padLeft(2, '0');
    String day = (date.day - 1).toString().padLeft(2, '0');
    url = '$url/2019$month$day-$awayAbbr-$homeAbbr/boxscore.json';

    Map<String, String> headers = {
      'Authorization': 'Basic ${apiKey.key}',
    };

    return http.get(url, headers: headers);
  }
}
