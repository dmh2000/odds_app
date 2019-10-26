import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart' as bloc;
import '../constants/constants.dart' as constants;
import '../constants/device_data.dart' as device;

class SelectLeague extends StatefulWidget {
  SelectLeague({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SelectLeagueState createState() => _SelectLeagueState();
}

class _SelectLeagueState extends State<SelectLeague> {
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc.GamesBloc _gamesBloc = BlocProvider.of<bloc.GamesBloc>(context);

    DateTime gameDay = _gamesBloc.gameDay;

    String date = '${gameDay.month}/${gameDay.day}/${gameDay.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Games For $date'),
        backgroundColor: constants.appBarColor,
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/stadium.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: BlocListener(
          bloc: _gamesBloc,
          listener: (context, bloc.GamesState state) {},
          child: BlocBuilder(
            bloc: _gamesBloc,
            builder: (BuildContext context, bloc.GamesState state) {
              if (state is bloc.GamesInitial) {
                return loading();
              } else if (state is bloc.GamesLoading) {
                return loading();
              } else if (state is bloc.GamesLoaded) {
                if (state.games.isEmpty()) {
                  return Center(
                    child: Text(
                      'No Games Today! Try Again Tomorrow!',
                      style: device.deviceData.homeTextStyle,
                    ),
                  );
                } else {
                  return SelectLeagueWidget();
                }
              } else {
                return null;
              }
            },
          ),
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
          "Checking For Games",
          style: device.deviceData.homeTextStyle,
        ),
        CircularProgressIndicator(),
      ],
    ));
  }
}

class SelectLeagueWidget extends StatelessWidget {
  const SelectLeagueWidget({
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
              Navigator.pushNamed(context, constants.routeNational);
            },
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage(
                      device.deviceData.imageScale(constants.imageNational)),
                ),
                Text(
                  constants.titleNational,
                  style: device.deviceData.buttonTextStyle,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, constants.routeAmerican);
            },
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage(
                      device.deviceData.imageScale(constants.imageAmerican)),
                ),
                Text(
                  constants.titleAmerican,
                  style: device.deviceData.buttonTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
