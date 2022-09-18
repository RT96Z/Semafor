import 'dart:js';

import 'package:flutter/material.dart';
import 'package:semafor/components/gameClock.dart';

import 'package:semafor/components/control_score.dart';

import 'package:semafor/firebase/game_list.dart';

import 'package:semafor/colors.dart';
import 'package:semafor/states/switch_state.dart';

class HomeView extends StatelessWidget {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: ClockControlls(),
              ),
              Flexible(fit: FlexFit.tight, flex: 1, child: ControlScore()),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(width: 800, height: 600, child: Switcher()),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [eventTrack()],
                  ),
                SizedBox(height: 15,width: 1,),
                  Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 300,
                            height: 500,
                                child: gamePlayersHomeList()
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: 300,
                            height: 500,
                              child: gamePlayersAwayList()
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOpenScoreboardGreyDarker,
                  foregroundColor: Colors.white,
                ),
                onPressed: (() {
                  
                }),
                child: Text('NAZAD'),
              ),
            ],
          )
        ])));
  }
}
