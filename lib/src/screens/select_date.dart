import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../bloc/games_event.dart' as gamesEvent;
import '../constants/constants.dart' as constants;
import '../constants/device_data.dart' as device;

class SelectDate extends StatelessWidget {
  /// a button for date select
  /// gets a text string and a reference to an onPressed function
  Widget _selectButton(String text, {@required VoidCallback onPressed}) {
    return RaisedButton(
      child: Text(
        text,
        style: constants.daySelectTextStyle,
      ),
      onPressed: onPressed,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(30.0),
      ),
      padding: EdgeInsets.all(20.0),
      textColor: Colors.white,
      color: Colors.blueGrey,
    );
  }

  /// onPressed function for selecting today's games
  VoidCallback _other(BuildContext context, bloc.GamesBloc gamesBloc) {
    return () {
      _selectDate(context, gamesBloc);
    };
  }

  /// onPressed function for selecting tomorrow's games
  VoidCallback _today(BuildContext context, bloc.GamesBloc gamesBloc) {
    return () {
      // set the date for tomorrow
      DateTime today = DateTime.now();
      // load the games immediately
      gamesBloc.dispatch(gamesEvent.GetGames(day: today));
      // go to the select league screen
      Navigator.pushNamed(context, constants.routeLeague);
    };
  }

  Future<Null> _selectDate(
      BuildContext context, bloc.GamesBloc gamesBloc) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // set the date Today
      DateTime today = picked;
      // load the games immediately
      gamesBloc.dispatch(gamesEvent.GetGames(day: today));
      // go to the select league screen
      Navigator.pushNamed(context, constants.routeLeague);
    }
  }

  /// build the select date widget
  @override
  Widget build(BuildContext context) {
    final bloc.GamesBloc gamesBloc = BlocProvider.of<bloc.GamesBloc>(context);
    final MediaQueryData mq = MediaQuery.of(context);

    // this screen is always called first so initialize the global device data object
    device.setDeviceType(mq.size.width);

    return Scaffold(
      appBar: AppBar(
        title: Text('Baseball Scores - Live or Historical'),
        backgroundColor: constants.appBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/baseball.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Spacer(flex: 1),
              _selectButton(
                " Today's Games ",
                onPressed: _today(context, gamesBloc),
              ),
              Spacer(flex: 2),
              _selectButton(
                "  Any Other Day  ",
                onPressed: _other(context, gamesBloc),
              ),
              Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
