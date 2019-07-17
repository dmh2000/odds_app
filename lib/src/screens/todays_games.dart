import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../constants/teams.dart';
import '../models/team_model.dart';

class TodaysGames extends StatefulWidget {
  final String _league;
  TodaysGames(String league) : _league = league;

  @override
  _TodaysGamesState createState() => _TodaysGamesState(_league);
}

class _TodaysGamesState extends State<TodaysGames> {
  final String _league;
  final TeamData _teamData;
  List<Team> _teams;

  _TodaysGamesState(String league)
      : _league = league,
        _teamData = TeamData() {
    print(league);
    _teams = _teamData.getTeamsByLeague(league);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_league League'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return AndroidTeamItem(teams: _teams, index: index);
        },
        itemCount: _teams.length,
      ),
    );
  }
}

class AndroidTeamItem extends StatelessWidget {
  const AndroidTeamItem({
    Key key,
    @required List<Team> teams,
    @required int index,
  })  : _teams = teams,
        _index = index,
        super(key: key);

  final List<Team> _teams;
  final int _index;

  @override
  Widget build(BuildContext context) {
    print(_teams[_index].name);
    print(_teams[_index].icon);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            print('${_teams[_index].name}');
          },
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(_teams[_index].icon),
            ),
            title: Text(
              '${_teams[_index].location} ${_teams[_index].name}',
              style: constants.buttonTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
