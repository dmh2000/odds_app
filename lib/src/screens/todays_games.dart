import 'package:flutter/material.dart';

class TodaysGames extends StatefulWidget {
  final String _league;
  TodaysGames(String league) : _league = league;

  @override
  _TodaysGamesState createState() => _TodaysGamesState(_league);
}

class _TodaysGamesState extends State<TodaysGames> {
  final String _league;

  _TodaysGamesState(String league) : _league = league;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(_league),
    );
  }
}
