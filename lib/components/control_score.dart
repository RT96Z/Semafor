import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:audioplayers/audioplayers.dart';

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
                    onPressed: () {
                      gameData
                          .doc('Home')
                          .update({'goals': FieldValue.increment(1)});

                      AudioPlayer().play(AssetSource('assets/ozbiljnoo2.wav'));
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
              SizedBox(height: 50,),
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
              SizedBox(height: 50,),
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
}
