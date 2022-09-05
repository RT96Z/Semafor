import 'package:flutter/material.dart';

import 'package:semafor/colors.dart';

class GameClockView1 extends StatelessWidget{
    final int currentTimeMilliseconds;
  final int defaultGameclock;
  final bool running;


  GameClockView1({
    required this.currentTimeMilliseconds,
    required this.defaultGameclock,
    required this.running,
  });

 String _stringTime() {
    var minutesString = _getMinutes(currentTimeMilliseconds).toString().padLeft(2, '0');

    var secondsString = _getSeconds(currentTimeMilliseconds).toString().padLeft(2, '0');

    return "$minutesString:$secondsString";
  }

@override
  build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,


      ),
       alignment: Alignment.topCenter,
      child: Center(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
            GestureDetector(
              child: Text(
                  _stringTime(),
                  style: TextStyle(
                      fontSize: 30,
                      color: kOpenScoreboardBlue,
                  ),
              ),
            ),
          ],
        ),
      )
    );
  }

  int _getMinutes(int milliseconds) {
    return (milliseconds ~/ (60 * 1000));
  }

  int _getSeconds (int milliseconds) {
    return (milliseconds - (_getMinutes(milliseconds) * 60 * 1000)) ~/ 1000;
  }

 



}