import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';

late VideoPlayerController _controller;




final CollectionReference gameData =
    FirebaseFirestore.instance.collection('game');

class ControlScore extends StatefulWidget {
  const ControlScore({super.key});

  @override
  State<ControlScore> createState() => _ControlScoreState();
}

class _ControlScoreState extends State<ControlScore> {



 

  @override
  Widget build(BuildContext context) {
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
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 110,
                height: 70,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.arrow_circle_up_sharp,
                      color: Colors.blue,
                      size: 60,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOpenScoreboardGreyDarker,
                      foregroundColor: Colors.white,
                    ),
                    label: Text("", textAlign: TextAlign.left), //GOAL
                    onPressed: () async {

                      gameData
                          .doc('Home')
                          .update({'goals': FieldValue.increment(1)});

                      setState(() {
                        //ŠALJE KOJI VIDEO PUSTUTI NA VIDEO EKRANU
                        FirebaseFirestore.instance
                            .collection('game')
                            .doc('Event')
                            .collection('Events')
                            .doc('Video')
                            .update({
                          'video': 1,
                        });
                        // SWITCH SA SCOREBOARDA NA VIDEO EKRAN
                        FirebaseFirestore.instance
                            .collection('game')
                            .doc('Event')
                            .collection('Events')
                            .doc('Video')
                            .update({
                          'videoIndex': 1,
                        });
                        Timer(Duration(seconds: 19), () {
                          setState(() {
                                                    FirebaseFirestore.instance
                            .collection('game')
                            .doc('Event')
                            .collection('Events')
                            .doc('Video')
                            .update({
                          'video': 0,
                        });

                            FirebaseFirestore.instance
                                .collection('game')
                                .doc('Event')
                                .collection('Events')
                                .doc('Video')
                                .update({
                              'videoIndex': 0,
                            });
                          });
                        });
                      });

                   
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 110,
                height: 70,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.red,
                      size: 60,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOpenScoreboardGreyDarker,
                      foregroundColor: Colors.white,
                    ),
                    label: Text("", textAlign: TextAlign.center), //NO GOAL
                    onPressed: () {
                      gameData
                          .doc('Home')
                          .update({'goals': FieldValue.increment(-1)});
                    }),
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOpenScoreboardGreyDarker,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Reset Score",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  gameData.doc('Home').update({'goals': 0});
                  deleteAllHome();
                },
              ),
            ],
          ),
          SizedBox(
            width: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Away',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kOpenScoreboardGreyDarker,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Reset Score",
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                onPressed: () {
                  gameData.doc('Away').update({'goals': 0});
                  deleteAllAway();
                },
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 70,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.arrow_circle_up_sharp,
                      color: Colors.blue,
                      size: 60,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOpenScoreboardGreyDarker,
                      foregroundColor: Colors.white,
                    ),
                    label: Text("", textAlign: TextAlign.left), //GOAL
                    onPressed: () {
                      gameData
                          .doc('Away')
                          .update({'goals': FieldValue.increment(1)});
                    }),
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 110,
                height: 70,
                child: ElevatedButton.icon(
                    icon: Icon(
                      Icons.arrow_circle_down_sharp,
                      color: Colors.red,
                      size: 60,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOpenScoreboardGreyDarker,
                      foregroundColor: Colors.white,
                    ),
                    label: Text("", textAlign: TextAlign.center), //NO GOAL
                    onPressed: () {
                      gameData
                          .doc('Away')
                          .update({'goals': FieldValue.increment(-1)});
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Future<void> deleteAllHome() async {
var collection = FirebaseFirestore.instance.collection('game').doc('Event').collection('homeEvent');
var snapshots = await collection.get();
for (var doc in snapshots.docs) {
  await doc.reference.delete();
}
}
  Future<void> deleteAllAway() async {
var collection = FirebaseFirestore.instance.collection('game').doc('Event').collection('awayEvent');
var snapshots = await collection.get();
for (var doc in snapshots.docs) {
  await doc.reference.delete();
}
}
}