import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc.dart' as bloc;
import '../bloc/games_event.dart';
import '../constants/constants.dart' as constants;

class SelectDate extends StatelessWidget {
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
      color: Colors.blueAccent,
    );
  }

  VoidCallback _today(BuildContext context, bloc.GamesBloc gamesBloc) {
    return () {
      DateTime today = DateTime.now();
      // load the games immediately
      gamesBloc.dispatch(GetGames(day: today));
      Navigator.pushNamed(context, constants.routeLeague);
    };
  }

  VoidCallback _tomorrow(BuildContext context, bloc.GamesBloc gamesBloc) {
    return () {
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
      // load the games immediately
      gamesBloc.dispatch(GetGames(day: tomorrow));
      Navigator.pushNamed(context, constants.routeLeague);
    };
  }

  VoidCallback _yesterday(BuildContext context, bloc.GamesBloc gamesBloc) {
    return () {
      DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
      // load the games immediately
      gamesBloc.dispatch(GetGames(day: yesterday));
      Navigator.pushNamed(context, constants.routeLeague);
    };
  }

  @override
  Widget build(BuildContext context) {
    final bloc.GamesBloc gamesBloc = BlocProvider.of<bloc.GamesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Which Games To See'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _selectButton(
                "Yesterday's Games",
                onPressed: _yesterday(context, gamesBloc),
              ),
              _selectButton(
                "Today's Games",
                onPressed: _today(context, gamesBloc),
              ),
              _selectButton(
                "Tomorrow's Games",
                onPressed: _tomorrow(context, gamesBloc),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
