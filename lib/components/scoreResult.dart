import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';

class showScore extends StatelessWidget {
  final String currentHomeScore;
  final String currentAwayScore;


  showScore({
    required this.currentHomeScore,
    required this.currentAwayScore,

  });

  @override
  build(BuildContext context) {
    return Container(

      height: 300,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getScore("Home", currentHomeScore),
            SizedBox(width: 400, ),
            Container(
              width: 50,
              height: 50,
              child: Text(':' ,style: TextStyle(height: 5, fontSize: 30, decorationColor: Colors.white ),),
            ),
            SizedBox(width: 400, ),
            _getScore("Away", currentAwayScore),
          ],
        ),
    );
  }

  Column _getScore(String title, String value, ) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  

                   
                  
                ],
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 80,
                  color: kOpenScoreboardBlue,
                ),
              ),
          ],
        ),
        
      ],
    );
  }

  
  

}
