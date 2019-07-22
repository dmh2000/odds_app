import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/game_model.dart';
import '../constants/constants.dart' as constants;
import '../bloc/bloc.dart' as bloc;

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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                    style: constants.homeTextStyle,
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
          style: constants.homeTextStyle,
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
    // final GamesBloc gamesBloc = BlocProvider.of<GamesBloc>(context);
    final bloc.BoxScoreBloc _boxScoreBloc = bloc.BoxScoreBloc();
    return BlocProvider(
      builder: (context) => _boxScoreBloc,
      child: Center(
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
      ),
    );
  }
}
