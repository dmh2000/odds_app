import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/game_model.dart';
import '../models/team_model.dart';
import '../constants/constants.dart';

//TODO show box score
class GameBox extends StatelessWidget {
  const GameBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context).settings.arguments;
    final TeamData td = TeamData();

    Team home = td.getTeamById(game.homeId);
    Team away = td.getTeamById(game.awayId);
    String awayText = '${away.location} ${away.name}';
    String homeText = '${home.location} ${home.name}';
    String gameText = '$awayText at $homeText';

    return Scaffold(
      appBar: AppBar(
        title: Text(gameText),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                top: 20.0,
                bottom: 20.0,
              ),
              child: Text(
                '11:05 AM',
                style: gameTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: <Widget>[
                  teamTitle(icon: away.icon, name: away.name),
                  Text(
                    'At',
                    style: gameTextStyle,
                  ),
                  teamTitle(icon: home.icon, name: home.name),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: matchup(0, 0, 0, 0),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: score(
                  game: game,
                  awayName: awayText,
                  homeName: homeText,
                  inning: 0),
            )
          ],
        ),
      ),
    );
  }

  Widget teamTitle({String icon, String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(icon),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
            name,
            style: gameTextStyle,
          ),
        ),
      ],
    );
  }

  Widget matchup(int homeOdds, int awayOdds, int over, int under) {
    String home = '${homeOdds.toString().padLeft(3, '0')}';
    home = (homeOdds >= 0) ? '+$home' : '-$home';
    String away = '${awayOdds.toString().padLeft(3, '0')}';
    away = (awayOdds >= 0) ? '+$away' : '-$away';

    return Container(
      margin: EdgeInsets.only(top: 40.0),
      child: Column(
        children: <Widget>[
          Text(
            'Matchup',
            style: gameTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Home',
                          style: matchupTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          home,
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Over',
                          style: matchupTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          over.toString().padLeft(3, '0'),
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Away',
                          style: matchupTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          away,
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Under',
                          style: matchupTextStyle,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text(
                          under.toString().padLeft(3, '0'),
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget score(
      {@required Game game,
      @required String awayName,
      @required homeName,
      @required int inning}) {
    String inningText = 'Inning : $inning';
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Score',
            style: gameTextStyle,
          ),
          scoreRow(
            col2: 'R',
            col3: 'H',
            col4: 'E',
          ),
          scoreRow(
            col1: awayName,
            col2: '00',
            col3: '00',
            col4: '00',
          ),
          scoreRow(
            col1: homeName,
            col2: '0',
            col3: '0',
            col4: '0',
          ),
          scoreRow(
            col1: 'Inning',
            col2: inning.toString(),
          ),
          scoreRow(
            col1: 'Status',
            col2: game.playedStatus.toLowerCase(),
          ),
        ],
      ),
    );
  }

  Widget scoreRow({
    String col1 = '',
    String col2 = '',
    String col3 = '',
    String col4 = '',
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              col1,
              style: gameTextStyle,
            ),
          ),
          flex: 5,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              col2,
              style: gameTextStyle,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: Text(
              col3,
              style: gameTextStyle,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: Text(
              col4,
              style: gameTextStyle,
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
