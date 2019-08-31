import 'package:flutter/material.dart';
import 'package:odds/src/constants/teams.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/constants/constants.dart' as constants;
import 'src/screens/select_date.dart';
import 'src/screens/select_league.dart';
import 'src/screens/league_games.dart';
import 'src/screens/box_score.dart';
import 'src/bloc/bloc.dart';

void main() => runApp(OddsApp());

class OddsApp extends StatelessWidget {
  final GamesBloc _gamesBloc = GamesBloc();
  final BoxScoreBloc _boxBloc = BoxScoreBloc();

  @override
  Widget build(BuildContext context) {
    // next the bloc providers
    return BlocProvider(
      builder: (context) => _gamesBloc,
      child: BlocProvider(
        builder: (context) => _boxBloc,
        child: MaterialApp(
            title: "Today's Games",
            theme: ThemeData(
              brightness: Brightness.light,
            ),
            initialRoute: constants.routeDate,
            routes: {
              constants.routeDate: (context) => SelectDate(),
              constants.routeLeague: (context) =>
                  SelectLeague(title: "Leagues"),
              constants.routeNational: (context) =>
                  GamesByLeague(leagueNational),
              constants.routeAmerican: (context) =>
                  GamesByLeague(leagueAmerican),
              constants.routeGameBox: (context) => BoxScore(),
            }),
      ),
    );
  }

  dispose() {
    // dispose of the blocs
    _gamesBloc.dispose();
    _boxBloc.dispose();
  }
}
