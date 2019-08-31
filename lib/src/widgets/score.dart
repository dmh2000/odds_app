import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../models/models.dart' as models;
import '../constants/device_data.dart' as device;

Widget scoreBox(
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
