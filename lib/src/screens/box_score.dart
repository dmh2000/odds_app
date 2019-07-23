import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../models/models.dart' as models;
import '../constants/device_data.dart' as device;

//TODO show box score
class BoxScore extends StatelessWidget {
  const BoxScore({Key key}) : super(key: key);
  @override
  Widget build(context) {
    final bloc.BoxScoreBloc _boxScoreBloc =
        BlocProvider.of<bloc.BoxScoreBloc>(context);
    final models.Game game = ModalRoute.of(context).settings.arguments;
    // final models.TeamData td = models.TeamData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Box Score'),
      ),
      body: BlocListener(
        bloc: _boxScoreBloc,
        listener: (context, bloc.BoxScoreState state) {},
        child: BlocBuilder(
          bloc: _boxScoreBloc,
          builder: (BuildContext context, bloc.BoxScoreState state) {
            if (state is bloc.BoxScoreInitial) {
              return loading();
            } else if (state is bloc.BoxScoreLoading) {
              return loading();
            } else if (state is bloc.BoxScoreLoaded) {
              return boxScoreWidget(state.boxScore, game);
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }

  Widget loading() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Loading game data",
          style: device.deviceData.homeTextStyle,
        ),
        CircularProgressIndicator(),
      ],
    ));
  }

  Widget boxScoreWidget(models.BoxScoreModel boxScore, models.Game game) {
    models.Team home = models.getTeamById(game.homeId);
    models.Team away = models.getTeamById(game.awayId);
    String awayText = '${away.location} ${away.name}';
    String homeText = '${home.location} ${home.name}';
    String gameText = '$awayText at $homeText';

    // change 24 hour time to AM/PM
    String ampm;
    int hour24 = game.startTime.hour;
    if (hour24 >= 12) {
      hour24 -= 12;
      ampm = 'PM';
    } else {
      ampm = 'AM';
    }

    // annotate if it is an interleage game
    String interleague = (home.league != away.league) ? '(IL)' : '';

    // construct the start time string
    String hour = hour24.toString().padLeft(2);
    String minute = game.startTime.minute.toString().padLeft(2, '0');
    String gameTime = '$hour:$minute $ampm $interleague';

    return Center(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 20.0,
              bottom: 20.0,
            ),
            child: Text(
              gameTime,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: <Widget>[
                teamTitle(icon: away.icon, name: away.name),
                Text(
                  'At',
                  style: device.deviceData.gameTextStyle,
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
                game: game, awayName: awayText, homeName: homeText, inning: 0),
          )
        ],
      ),
    );
  }

  Widget teamTitle({String icon, String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(device.deviceData.imageScale(icon)),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Text(
            name,
            style: device.deviceData.gameTextStyle,
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
            style: device.deviceData.gameTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Over',
                          style: device.deviceData.matchupTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, right: 10.0),
                        child: Text(
                          'Under',
                          style: device.deviceData.matchupTextStyle,
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
                          style: device.deviceData.matchupTextStyle,
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
      {@required models.Game game,
      @required String awayName,
      @required homeName,
      @required int inning}) {
    String status = game.playedStatus.toLowerCase();
    if (status == 'unplayed') {
      status = 'not started';
    }

    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Score',
            style: device.deviceData.gameTextStyle,
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
          statusRow(
            col1: 'Status',
            col2: status,
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
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 5,
        ),
        Expanded(
          child: Container(
            child: Text(
              col2,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: Text(
              col3,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            child: Text(
              col4,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  Widget statusRow({
    String col1 = '',
    String col2 = '',
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              col1,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 2,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              col2,
              style: device.deviceData.gameTextStyle,
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }
}
