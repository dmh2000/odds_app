import 'package:flutter/material.dart';
import 'package:odds/src/constants/teams.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/constants/constants.dart' as constants;
import 'src/screens/select_league.dart';
import 'src/screens/league_games.dart';
import 'src/bloc/bloc.dart';

void main() => runApp(OddsApp());

class OddsApp extends StatelessWidget {
  final GamesBloc _gamesBloc = GamesBloc();
  @override
  Widget build(BuildContext context) {
    // load the games immediately
    _gamesBloc.dispatch(GetGames());
    return BlocProvider(
      builder: (context) => _gamesBloc,
      child: MaterialApp(
          title: "Today's Games",
          theme: ThemeData(
            brightness: Brightness.light,
          ),
          initialRoute: constants.routeHome,
          routes: {
            constants.routeHome: (context) =>
                SelectLeague(title: "Today's Games"),
            constants.routeNational: (context) => LeagueGames(leagueNational),
            constants.routeAmerican: (context) => LeagueGames(leagueAmerican),
          }),
    );
  }
}
