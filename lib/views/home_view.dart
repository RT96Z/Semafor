import 'package:flutter/material.dart';
import 'package:semafor/components/gameClock.dart';
import 'package:semafor/components/scoreControls.dart';
import 'package:semafor/components/scoreResult.dart';
import 'package:semafor/components/showTime.dart';
import 'package:semafor/states/home_state.dart';
import 'package:semafor/colors.dart';
import 'package:semafor/states/switch_state.dart';

class HomeView extends HomeState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: OrientationBuilder(builder: (context, orientation) {
          return mainControls();
        }));
  }

  Center mainControls() {
    return Center(
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: 
        showScore(
                  currentHomeScore: mHomeScore.toString(),
                  currentAwayScore: mAwayScore.toString(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: kOpenScoreboardGreyDark,
                    )),
              ),
              Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: 
        GameClockView1(
                    currentTimeMilliseconds: mCurrentGameTimeMilliseconds,
                    defaultGameclock: mDefaultGameTimeMilliseconds,
                    running: mIsRunning,
                  )),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: kOpenScoreboardGreyDark,
                    )),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child:
              GameClockView(
                currentTimeMilliseconds: mCurrentGameTimeMilliseconds,
                defaultGameclock: mDefaultGameTimeMilliseconds,
                running: mIsRunning,
                startFunction: start,
                stopFunction: stop,
                resetGameFunction: resetGameClock,
                endHalf: endFirstHalf,
                fullTime: endSecondHalf,
                setGameFunction: setGameClock,
                setDefaultGameFunction: setDefaultGameClock,
              ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child:
              ScoreControl(
                currentHomeScore: mHomeScore.toString(),
                currentAwayScore: mAwayScore.toString(),
  
                addHomeFunction: () {
                  changeHomeScore(1);
                },
                removeHomeFunction: () {
                  changeHomeScore(-1);
                },
                resetHomeFunction: () {
                  resetHomeScore();
                },
                addAwayFunction: () {
                  changeAwayScore(1);
                },
                removeAwayFunction: () {
                  changeAwayScore(-1);
                },
                resetAwayFunction: () {
                  resetAwayScore();
                },

              )),
            ],
          ),
           Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Switcher()

              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: (() {
                    
                    
               Navigator.pop(context);
                    

                  }),

                  child: Text('NAZAD'),
                ),),
            ],
          ),

        ])));
  }
}
