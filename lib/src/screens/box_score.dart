import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../models/models.dart' as models;
import '../constants/device_data.dart' as device;
import '../constants/constants.dart' as constants;
import '../widgets/score.dart' as score;

class BoxScore extends StatelessWidget {
  const BoxScore({Key key}) : super(key: key);
  @override
  Widget build(context) {
    final bloc.BoxScoreBloc _boxScoreBloc =
        BlocProvider.of<bloc.BoxScoreBloc>(context);
    final models.Game game = ModalRoute.of(context).settings.arguments;

    // final models.TeamData td = models.TeamData();
    return BlocListener(
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
            return boxScaffold(context, state, game);
          } else {
            return loading();
          }
        },
      ),
    );
  }

  Widget loading() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Game Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget boxScaffold(context, state, models.Game game) {
    DateTime day = game.startTime;
    String date = '${day.month}/${day.day}/${day.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Box Score : $date'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.popUntil(context,
                  (route) => route.settings.name == constants.routeDate);
            },
            icon: Icon(
              Icons.home,
            ),
          )
        ],
      ),
      body: boxScoreWidget(context, state.boxScore, game),
    );
  }

  Widget boxScoreWidget(
      BuildContext context, models.BoxScoreModel boxScore, models.Game game) {
    final bloc.BoxScoreBloc boxScoreBloc =
        BlocProvider.of<bloc.BoxScoreBloc>(context);

    // get team information
    models.Team home = models.getTeamById(game.homeId);
    models.Team away = models.getTeamById(game.awayId);

    // change 24 hour time to AM/PM
    String startTime = game.dateTimeString;

    // annotate if it is an interleage game
    String interleague = (home.league != away.league) ? '(IL)' : '';

    // construct the start time string
    String gameTime = '$startTime $interleague';
    double boxMargin = device.deviceData.boxMargin;
    TextStyle gameTextStyle = device.deviceData.gameTextStyle;
    return RefreshIndicator(
      onRefresh: () async {
        boxScoreBloc.dispatch(
          bloc.UpdateBoxScore(game: game),
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
                  // Container(
                  //   margin: EdgeInsets.only(bottom: boxMargin),
                  //   child: matchup(0, 0, 0, 0),
                  // ),
                  Container(
                    margin: EdgeInsets.only(bottom: boxMargin),
                    child: score.scoreBox(
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
}
