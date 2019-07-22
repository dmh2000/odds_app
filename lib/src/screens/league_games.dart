import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odds/src/constants/constants.dart';
import '../bloc/bloc.dart';
import '../models/team_model.dart';
import '../models/game_model.dart';
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
    // filter
    return games.where((Game game) {
      Team home = TeamData().getTeamById(game.homeId);
      Team away = TeamData().getTeamById(game.awayId);
      return (home.league == _league) || (away.league == _league);
    }).toList();
  }
}

class AndroidGameItem extends StatelessWidget {
  final Game game;
  final BoxScoreBloc _boxScoreBloc = BoxScoreBloc();

  AndroidGameItem({
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

    // change 24 hour time to AM/PM
    String ampm;
    int hour24 = game.startTime.hour;
    if (hour24 >= 12) {
      hour24 -= 12;
      ampm = 'PM';
    } else {
      ampm = 'AM';
    }

    // annotate if it is an interleage game
    String interleague = (home.league != away.league) ? '(IL)' : '';

    // construct the start time string
    String hour = hour24.toString().padLeft(2);
    String minute = game.startTime.minute.toString().padLeft(2, '0');
    String start = '$hour:$minute $ampm $interleague';

    return BlocProvider(
      builder: (context) => _boxScoreBloc,
      child: GestureDetector(
        onTap: () {
          // start fetch of game box score
          _boxScoreBloc
              .dispatch(GetBoxScore(awayId: game.awayId, homeId: game.homeId));

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
                    style: atTextStyle,
                  ),
                  homeTeam(team: home),
                ],
              ),
              Text(
                start,
                style: constants.timeTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget awayTeam({
    @required Team team,
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
                style: activeTextStyle,
              ),
            ),
            CircleAvatar(
              backgroundImage: AssetImage(team.icon),
            ),
          ],
        ),
      ),
    );
  }
}

Widget homeTeam({
  @required Team team,
}) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage(team.icon),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0),
            child: Text(
              team.name,
              style: activeTextStyle,
            ),
          ),
        ],
      ),
    ),
  );
}
