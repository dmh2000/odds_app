import 'package:flutter/material.dart';
import 'package:odds/src/constants/teams.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'src/constants/constants.dart' as constants;
import 'src/screens/screens.dart' as screens;
import 'src/bloc/bloc.dart' as bloc;

void main() => runApp(OddsApp());

class OddsApp extends StatelessWidget {
  // bloc for list of games
  final bloc.GamesBloc _gamesBloc = bloc.GamesBloc();
  // bloc for box score for a specific game
  final bloc.BoxScoreBloc _boxBloc = bloc.BoxScoreBloc();

  @override
  Widget build(BuildContext context) {
    // nest the bloc providers so all screens can access them
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
              // default : select yesterday,today or tomorrow
              constants.routeDate: (context) => screens.SelectDate(),
              // select national or american league
              constants.routeLeague: (context) =>
                  screens.SelectLeague(title: "Leagues"),
              // show national league games
              constants.routeNational: (context) =>
                  screens.GamesByLeague(leagueNational),
              // show american league games
              constants.routeAmerican: (context) =>
                  screens.GamesByLeague(leagueAmerican),
              // show box score for a specific game
              constants.routeGameBox: (context) => screens.BoxScore(),
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
