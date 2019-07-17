import 'package:flutter/material.dart';
import 'package:odds/src/constants/teams.dart';
import 'src/constants/constants.dart' as constants;
import 'src/screens/odds_home.dart';
import 'src/screens/todays_games.dart';

void main() => runApp(OddsApp());

class OddsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Todays Games',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        initialRoute: constants.routeHome,
        routes: {
          constants.routeHome: (context) => OddsHome(title: 'Todays Games'),
          constants.routeNational: (context) => TodaysGames(leagueNational),
          constants.routeAmerican: (context) => TodaysGames(leagueAmerican),
        });
  }
}
