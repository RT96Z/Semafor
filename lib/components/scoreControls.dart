import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';

class ScoreControl extends StatelessWidget {
  final String currentHomeScore;
  final String currentAwayScore;

  final VoidCallback addHomeFunction;
  final VoidCallback removeHomeFunction;
  final VoidCallback resetHomeFunction;
  final VoidCallback addAwayFunction;
  final VoidCallback removeAwayFunction;
  final VoidCallback resetAwayFunction;

  ScoreControl({
    required this.currentHomeScore,
    required this.currentAwayScore,
    required this.addHomeFunction,
    required this.removeHomeFunction,
    required this.resetHomeFunction,
    required this.addAwayFunction,
    required this.removeAwayFunction,
    required this.resetAwayFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      width: 630,
      height: 200,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _getScore("Home", currentHomeScore, addHomeFunction,
              removeHomeFunction, resetHomeFunction),
          SizedBox(
            width: 150,
          ),
          _getScore("Away", currentAwayScore, addAwayFunction,
              removeAwayFunction, resetAwayFunction),
        ],
      ),
    );
  }

  Column _getScore(String title, String value, VoidCallback add,
      VoidCallback remove, VoidCallback reset) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: TextStyle(
            fontSize: 25,
            color: kOpenScoreboardBlue,
          ),
        ),
         SizedBox(
          width: 90,
          height: 50,

          child: ElevatedButton.icon(
            icon: Icon(
              Icons.arrow_circle_up_sharp,
              color: Colors.blue,
              size: 50,
            ),
            style: ElevatedButton.styleFrom(
              primary: kOpenScoreboardGreyDarker,
              onPrimary: Colors.white,
            ),
            label: Text("", textAlign: TextAlign.left), //GOAL
            onPressed: add,
          ),
        ),
        SizedBox(
          width: 90,
          height: 50,
          child: ElevatedButton.icon(
            icon: Icon(
              Icons.arrow_circle_down_sharp,
              color: Colors.blue,
              size: 50,
            ),
            style: ElevatedButton.styleFrom(
              primary: kOpenScoreboardGreyDarker,
              onPrimary: Colors.white,
            ),
            label: Text("", textAlign: TextAlign.center), //NO GOAL
            onPressed: remove,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: kOpenScoreboardGreyDarker,
            onPrimary: Colors.white,
          ),
          child: Text(
            "Reset Score",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: reset,
        ),
      ],
    );
  }
}
