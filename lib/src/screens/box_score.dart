import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../models/models.dart' as models;
import '../constants/device_data.dart' as device;

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
              return boxScoreWidget(context, state.boxScore, game);
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

  Widget boxScoreWidget(
      BuildContext context, models.BoxScoreModel boxScore, models.Game game) {
    final bloc.BoxScoreBloc boxScoreBloc =
        BlocProvider.of<bloc.BoxScoreBloc>(context);

    // get team information
    models.Team home = models.getTeamById(game.homeId);
    models.Team away = models.getTeamById(game.awayId);

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
    double boxMargin = device.deviceData.boxMargin;
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    return RefreshIndicator(
      onRefresh: () async {
        boxScoreBloc.dispatch(
          bloc.UpdateBoxScore(awayId: away.id, homeId: home.id),
        );
      },
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: boxMargin * 2.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: boxMargin,
                      bottom: boxMargin,
                    ),
                    child: Text(
                      gameTime,
                      style: gameTextStyle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: boxMargin),
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
                    margin: EdgeInsets.only(bottom: boxMargin),
                    child: matchup(0, 0, 0, 0),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: boxMargin),
                    child: score(
                        game: game,
                        homeName: home.name,
                        awayName: away.name,
                        boxScore: boxScore),
                  )
                ],
              ),
            ),
          ),
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
          margin: EdgeInsets.only(left: device.deviceData.boxMargin),
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
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    TextStyle matchupTextStyle = device.deviceData.matchupTextStyle;
    double boxMargin = device.deviceData.boxMargin;
    return Container(
      margin: EdgeInsets.only(top: boxMargin * 2.0),
      child: Column(
        children: <Widget>[
          Text(
            'Matchup',
            style: gameTextStyle,
          ),
          Container(
            margin: EdgeInsets.only(left: boxMargin, right: boxMargin),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                        margin: EdgeInsets.only(top: boxMargin),
                        child: Text(
                          home,
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                        margin: EdgeInsets.only(top: boxMargin),
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
                        margin:
                            EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                        margin: EdgeInsets.only(top: boxMargin),
                        child: Text(
                          away,
                          style: matchupTextStyle,
                        ),
                      ),
                      flex: 1,
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                        margin: EdgeInsets.only(top: boxMargin),
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
      {@required models.Game game,
      @required String awayName,
      @required String homeName,
      @required models.BoxScoreModel boxScore}) {
    // get game status and convert as needed
    String status = boxScore.status;

    // get reactive parameters
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    double boxMargin = device.deviceData.boxMargin;
    return Container(
      margin: EdgeInsets.only(top: boxMargin),
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
            col2: boxScore.awayRuns.toString(),
            col3: boxScore.awayHits.toString(),
            col4: boxScore.awayErrors.toString(),
          ),
          scoreRow(
            col1: homeName,
            col2: boxScore.homeRuns.toString(),
            col3: boxScore.homeHits.toString(),
            col4: boxScore.homeErrors.toString(),
          ),
          scoreRow(
            col1: 'Inning',
            col2: boxScore.inning.toString(),
          ),
          statusRow(
            col1: 'Game Status',
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
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    double boxMargin = device.deviceData.boxMargin;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: boxMargin),
            child: Text(
              col1,
              style: gameTextStyle,
            ),
          ),
          flex: 5,
        ),
        Expanded(
          child: Container(
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

  Widget statusRow({
    String col1 = '',
    String col2 = '',
  }) {
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    double boxMargin = device.deviceData.boxMargin;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: boxMargin),
            child: Text(
              col1,
              style: gameTextStyle,
            ),
          ),
          flex: 5,
        ),
        Expanded(
          child: Container(
            child: Text(
              col2,
              style: gameTextStyle,
            ),
          ),
          flex: 3,
        ),
      ],
    );
  }
}
