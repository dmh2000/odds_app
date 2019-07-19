import 'package:flutter/material.dart';
import '../models/game_model.dart';

//TODO show box score
class GameBox extends StatelessWidget {
  const GameBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Game game = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(game.toString()),
      ),
      body: Container(
        child: Text(game.toString()),
      ),
    );
  }
}
