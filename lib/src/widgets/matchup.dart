import 'package:flutter/material.dart';
import '../constants/device_data.dart' as device;

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
                      margin: EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                      margin: EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                      margin: EdgeInsets.only(top: boxMargin, right: boxMargin),
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
                      margin: EdgeInsets.only(top: boxMargin, right: boxMargin),
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
