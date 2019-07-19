import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odds/src/constants/constants.dart';
import '../bloc/bloc.dart';
import '../models/team_model.dart';
import '../models/game_model.dart';
import '../constants/teams.dart';
import '../constants/constants.dart' as constants;

class GamesByLeague extends StatelessWidget {
  final String _league;

  GamesByLeague(this._league);

  @override
  @override
  Widget build(BuildContext context) {
    final GamesBloc _gamesBloc = BlocProvider.of<GamesBloc>(context);

    return BlocBuilder<GamesEvent, GamesState>(
      bloc: _gamesBloc,
      builder: (context, GamesState state) {
        List<Game> leagueGames;
        if (state is GamesLoaded) {
          leagueGames = gamesInLeague(state.games.games);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text('$_league League'),
          ),
          body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              Game game = leagueGames[index];
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

  List<Game> gamesInLeague(List<Game> games) {
    return games.where((Game game) {
      Team home = TeamData().getTeamById(game.homeId);
      Team away = TeamData().getTeamById(game.awayId);
      return (home.league == _league) || (away.league == _league);
    }).toList();
  }
}

class AndroidGameItem extends StatelessWidget {
  final Game game;

  const AndroidGameItem({
    @required Game game,
    Key key,
  })  : game = game,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // get data about team
    TeamData td = TeamData();
    Team home = td.getTeamById(game.homeId);
    Team away = td.getTeamById(game.awayId);

    //TODO : change time to AM/PM
    String hour = game.startTime.hour.toString().padLeft(2);
    String minute = game.startTime.minute.toString().padLeft(2, '0');
    String start = '$hour:$minute';

    return GestureDetector(
      onTap: () {
        print(game.toString());
        Navigator.pushNamed(context, constants.routeGameBox, arguments: game);
      },
      child: Card(
        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10.0),
                          child: Text(
                            home.name,
                            style: activeTextStyle,
                          ),
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(home.icon),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'At',
                  style: atTextStyle,
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: AssetImage(away.icon),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            away.name,
                            style: activeTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text(
              start,
              style: constants.timeTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
