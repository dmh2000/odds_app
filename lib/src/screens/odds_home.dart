import 'package:flutter/material.dart';
import '../constants/constants.dart' as constants;

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
    //

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
                    constants.routeNational,
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
                    constants.routeAmerican,
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
