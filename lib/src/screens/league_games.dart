import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../models/models.dart' as models;
import '../widgets/android_game_item.dart' as gameItem;
import '../constants/constants.dart' as constants;

class GamesByLeague extends StatelessWidget {
  final String _league;

  GamesByLeague(this._league);

  @override
  @override
  Widget build(BuildContext context) {
    final bloc.GamesBloc _gamesBloc = BlocProvider.of<bloc.GamesBloc>(context);

    DateTime day;
    String date;

    return BlocBuilder<bloc.GamesEvent, bloc.GamesState>(
        bloc: _gamesBloc,
        builder: (context, bloc.GamesState state) {
          List<models.Game> leagueGames;
          if (state is bloc.GamesLoaded) {
            leagueGames = gamesInLeague(state.games.games);
            day = state.date;
            date = '${day.month}/${day.day}/${day.year}';
            return Scaffold(
              appBar: AppBar(
                title: Text('$_league : $date'),
                backgroundColor: constants.appBarColor,
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == constants.routeDate);
                    },
                    icon: Icon(
                      Icons.home,
                    ),
                  )
                ],
              ),
              body: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  models.Game game = leagueGames[index];
                  return gameItem.AndroidGameItem(
                    game: game,
                  );
                },
                itemCount: leagueGames.length,
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('No Games'),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.popUntil(
                          context,
                          (route) =>
                              route.settings.name == constants.routeDate);
                    },
                    icon: Icon(
                      Icons.home,
                    ),
                  )
                ],
              ),
            );
          }
        });
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
