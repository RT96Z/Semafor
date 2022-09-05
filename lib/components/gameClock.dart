import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';

int liveTime = 0, normalTime = 0;
int onPressedTime = 0;
int timeControlls = 0;

final CollectionReference saljemVrijeme =
    FirebaseFirestore.instance.collection('game');

class ClockControlls extends StatefulWidget {
  const ClockControlls({Key? key}) : super(key: key);

  @override
  State<ClockControlls> createState() => _ClockControllsState();
}

class _ClockControllsState extends State<ClockControlls> {


@override
  build(BuildContext context) {
    return Container(
      height: 200,
      width: 580,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Scoreboard",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor:  kOpenScoreboardGreyDarker,
                        foregroundColor: Colors.white
                      ),
                  onPressed: () {
                          setState(() {
                            if (timeControlls == 0) {
                              onPressedTime =
                                  DateTime.now().millisecondsSinceEpoch;
                              timeControlls = 1;
                            } else if (timeControlls == 2) {
                              onPressedTime = DateTime.now().millisecondsSinceEpoch - 2700000;
                              timeControlls = 1;
                            }
                               saljemVrijeme.doc('Time').update({'index': 1, });
                              saljemVrijeme.doc('Time').update({'onClick': onPressedTime, });
                          
                          });
                        },
                  child: const Text('Start'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor:  kOpenScoreboardGreyDarker,
                        foregroundColor: Colors.white,
                      ),
                                          onPressed: () {
                          setState(() {
                            timeControlls = 0;
                            saljemVrijeme.doc('Time').update({'index': 0, });
                                 

                          });
                        },

                  child: const Text('Reset Game Clock'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor:  kOpenScoreboardGreyDarker,
                        foregroundColor: Colors.white,
                      ),
                 onPressed: () {
                          setState(() {
                            timeControlls = 2;
                            saljemVrijeme.doc('Time').update({'index': 2, });
                          });
                        },

                  child: const Text('End of FIRST HALF'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        backgroundColor:  kOpenScoreboardGreyDarker,
                        foregroundColor: Colors.white,
                      ),
                  onPressed: () {
                          setState(() {
                            timeControlls = 3;
                            saljemVrijeme.doc('Time').update({'index': 3, });
                          });
                        },

                  child: const Text('End of GAME'),
                ),
              ]
            ),
          ],
        ),
      )
    );
  }
}