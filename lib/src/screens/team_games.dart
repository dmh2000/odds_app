import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart';
import '../constants/constants.dart' as constants;
import '../models/models.dart' as models;

class TeamsByLeague extends StatelessWidget {
  final String _league;
  final List<models.Team> _teams;

  TeamsByLeague(this._league) : _teams = models.getTeamsByLeague(_league);

  @override
  @override
  Widget build(BuildContext context) {
    // final GamesBloc gamesBloc = BlocProvider.of<GamesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('$_league League'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return AndroidTeamItem(team: _teams[index]);
        },
        itemCount: _teams.length,
      ),
    );
  }
}

class AndroidTeamItem extends StatelessWidget {
  const AndroidTeamItem({
    Key key,
    @required models.Team team,
  })  : _team = team,
        super(key: key);

  final models.Team _team;

  @override
  Widget build(BuildContext context) {
    final GamesBloc _gamesBloc = BlocProvider.of<GamesBloc>(context);

    return BlocBuilder<GamesEvent, GamesState>(
        bloc: _gamesBloc,
        builder: (BuildContext context, GamesState state) {
          // find if team has a game
          int id = _team.id;
          models.Game game;

          if (state is GamesLoaded) {
            game = state.games.getGameByTeam(id);

            state.games.games.forEach((g) {
              int hid = g.homeId;
              int aid = g.awayId;
              models.Team home = models.getTeamById(hid);
              if (home == null) {
                print("home: $hid");
              }
              models.Team away = models.getTeamById(aid);
              if (away == null) {
                print("away: $aid");
              }
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('${_team.name}');
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(_team.icon),
                  ),
                  title: Text(
                    '${_team.location} ${_team.name}',
                    style: (game != null)
                        ? constants.activeTextStyle
                        : constants.inactiveTextStyle,
                  ),
                ),
              ),
            ],
          );
        });
  }
}

class AndroidGameitem extends StatelessWidget {
  const AndroidGameitem({
    Key key,
    @required models.Team team,
  })  : _team = team,
        super(key: key);

  final models.Team _team;

  @override
  Widget build(BuildContext context) {
    final GamesBloc _gamesBloc = BlocProvider.of<GamesBloc>(context);

    return BlocBuilder<GamesEvent, GamesState>(
        bloc: _gamesBloc,
        builder: (BuildContext context, GamesState state) {
          // find if team has a game
          int id = _team.id;
          models.Game game;

          if (state is GamesLoaded) {
            game = state.games.getGameByTeam(id);

            state.games.games.forEach((g) {
              int hid = g.homeId;
              int aid = g.awayId;
              models.Team home = models.getTeamById(hid);
              if (home == null) {
                print("home: $hid");
              }
              models.Team away = models.getTeamById(aid);
              if (away == null) {
                print("away: $aid");
              }
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  print('${_team.name}');
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(_team.icon),
                  ),
                  title: Text(
                    '${_team.location} ${_team.name}',
                    style: (game != null)
                        ? constants.activeTextStyle
                        : constants.inactiveTextStyle,
                  ),
                ),
              ),
            ],
          );
        });
  }
}
