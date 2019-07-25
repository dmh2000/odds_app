import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../models/models.dart' as models;
import '../constants/constants.dart' as constants;
import '../constants/device_data.dart' as device;

class GamesByLeague extends StatelessWidget {
  final String _league;

  GamesByLeague(this._league);

  @override
  @override
  Widget build(BuildContext context) {
    final bloc.GamesBloc _gamesBloc = BlocProvider.of<bloc.GamesBloc>(context);

    return BlocBuilder<bloc.GamesEvent, bloc.GamesState>(
      bloc: _gamesBloc,
      builder: (context, bloc.GamesState state) {
        List<models.Game> leagueGames;
        if (state is bloc.GamesLoaded) {
          leagueGames = gamesInLeague(state.games.games);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('$_league League'),
          ),
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              models.Game game = leagueGames[index];
              return AndroidGameItem(
                game: game,
              );
            },
            itemCount: leagueGames.length,
          ),
        );
      },
    );
  }

  List<models.Game> gamesInLeague(List<models.Game> games) {
    // filter
    return games.where((models.Game game) {
      models.Team home = models.getTeamById(game.homeId);
      models.Team away = models.getTeamById(game.awayId);
      return (home.league == _league) || (away.league == _league);
    }).toList();
  }
}

class AndroidGameItem extends StatelessWidget {
  final models.Game game;

  AndroidGameItem({
    @required models.Game game,
    Key key,
  })  : game = game,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc.BoxScoreBloc _boxScoreBloc =
        BlocProvider.of<bloc.BoxScoreBloc>(context);

    // get data about team
    models.Team home = models.getTeamById(game.homeId);
    models.Team away = models.getTeamById(game.awayId);

    // change 24 hour time to AM/PM
    // change 24 hour time to AM/PM
    String startTime = game.timeString;

    // annotate if it is an interleage game
    String interleague = (home.league != away.league) ? '(IL)' : '';

    // construct the start time string
    String start = '$startTime $interleague';

    return GestureDetector(
      onTap: () {
        // start fetch of game box score
        _boxScoreBloc.dispatch(bloc.GetBoxScore(game: game));

        // route to the selected game box score
        Navigator.pushNamed(context, constants.routeGameBox, arguments: game);
      },
      child: Card(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                awayTeam(team: away),
                Text(
                  'At',
                  style: device.deviceData.atTextStyle,
                ),
                homeTeam(team: home),
              ],
            ),
            Text(
              start,
              style: device.deviceData.timeTextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget awayTeam({
    @required models.Team team,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Text(
                team.name,
                style: device.deviceData.activeTextStyle,
              ),
            ),
            CircleAvatar(
              backgroundImage:
                  AssetImage(device.deviceData.imageScale(team.icon)),
            ),
          ],
        ),
      ),
    );
  }
}

Widget homeTeam({
  @required models.Team team,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage:
                AssetImage(device.deviceData.imageScale(team.icon)),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              team.name,
              style: device.deviceData.activeTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
}
