import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart' as bloc;
import '../constants/constants.dart' as constants;
import '../models/game_model.dart';
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
    final MediaQueryData mq = MediaQuery.of(context);

    // this screen is always called first so initialize the global device data object
    device.setDeviceType(mq.size.width);

    DateTime now = DateTime.now();
    String date = '${now.month}/${now.day}/${now.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text('Today is $date'),
      ),
      body: BlocListener(
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
                return SelectLeagueWidget(state.games);
              }
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
          "Checking For Today's Games",
          style: device.deviceData.homeTextStyle,
        ),
        CircularProgressIndicator(),
      ],
    ));
  }
}

class SelectLeagueWidget extends StatelessWidget {
  const SelectLeagueWidget(
    Games games, {
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
