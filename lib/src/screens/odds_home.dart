import 'package:flutter/material.dart';

import '../constants/constants.dart' as constants;
import '../bloc/bloc.dart';

class OddsHome extends StatefulWidget {
  OddsHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OddsHomeState createState() => _OddsHomeState();
}

class _OddsHomeState extends State<OddsHome> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GamesBloc gamesBloc = GamesBloc();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              print(constants.routeNational);
              Navigator.pushNamed(context, constants.routeNational);
            },
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage(constants.imageNational),
                ),
                Text(
                  constants.titleNational,
                  style: constants.buttonTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              print(constants.routeAmerican);
              Navigator.pushNamed(context, constants.routeAmerican);
            },
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage(constants.imageAmerican),
                ),
                Text(
                  constants.titleAmerican,
                  style: constants.buttonTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
