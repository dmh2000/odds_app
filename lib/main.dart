import 'package:flutter/material.dart';
import 'src/constants/constants.dart' as constants;
import 'src/screens/odds_home.dart';
import 'src/screens/todays_games.dart';

void main() => runApp(OddsApp());

class OddsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MLB Odds',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => OddsHome(title: 'MLB Odds : Todays Games'),
          constants.routeNational: (context) =>
              TodaysGames(constants.routeNational),
          constants.routeAmerican: (context) =>
              TodaysGames(constants.routeAmerican),
        });
  }
}
