import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semafor/components/postave.dart';
import 'package:semafor/components/zamjene.dart';
import 'package:semafor/firebase/scorer_list.dart';
import '../colors.dart';
import 'dart:async';
import 'package:firebase_storage/firebase_storage.dart';

enum WidgetMarker { Kartoni, Reklame, Events }

var FireSwitch = FirebaseFirestore.instance
    .collection('game')
    .doc('Event')
    .collection('Events')
    .doc('Video');

var FirestoreEvent = FirebaseFirestore.instance.collection('game').doc('Event').collection('Events');

final CollectionReference kartoni =
    FirebaseFirestore.instance.collection('game');

class Switcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwitcherBodyWidget();
  }
}

class SwitcherBodyWidget extends StatefulWidget {
  const SwitcherBodyWidget({super.key});

  @override
  State<SwitcherBodyWidget> createState() => _SwitcherBodyWidgetState();
}

class _SwitcherBodyWidgetState extends State<SwitcherBodyWidget> {
  WidgetMarker SelectedWidgetMarker = WidgetMarker.Kartoni;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Kartoni;
                    });
                  },
                  child: Text('Kartoni'),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kOpenScoreboardBlue),
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Reklame;
                    });
                  },
                  child: Text('Reklame'),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Events;
                    });
                  },
                  child: Text('Events'),
                )),
          ],
        ),
        Container(
          child: getCustomContainer(),
        ),
      ],
    );
  }

  Widget getCustomContainer() {
    switch (SelectedWidgetMarker) {
      case WidgetMarker.Kartoni:
        return KartoniContainer();
      case WidgetMarker.Reklame:
        return ReklameContainer();
      case WidgetMarker.Events:
        return EventsContainer();
    }
    // return KartoniContainer();
  }

  Widget KartoniContainer() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        height: 600,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 50,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: Text('Žuti karton'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      padding: EdgeInsets.all(30)),
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('game')
                          .doc('Event')
                          .collection('Events')
                          .doc('Cards')
                          .update({
                        'index': 1,
                      });
                      Timer(Duration(seconds: 7), () {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('game')
                              .doc('Event')
                              .collection('Events')
                              .doc('Cards')
                              .update({
                            'index': 0,
                          });
                        });
                      });
                    });
                  },
                ),
                SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, padding: EdgeInsets.all(30)),
                  child: Text('Crveni karton'),
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('game')
                          .doc('Event')
                          .collection('Events')
                          .doc('Cards')
                          .update({
                        'index': 2,
                      });
                      Timer(Duration(seconds: 7), () {
                        setState(() {
                          FirebaseFirestore.instance
                              .collection('game')
                              .doc('Event')
                              .collection('Events')
                              .doc('Cards')
                              .update({
                            'index': 0,
                          });
                        });
                      });
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget ReklameContainer() {
    return Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 35,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.black),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white70)),
                      onPressed: () {
                        setState(() {
                          // SWITCH SA SCOREBOARDA NA VIDEO EKRAN
                          FirebaseFirestore.instance
                              .collection('game')
                              .doc('Event')
                              .collection('Events')
                              .doc('Video')
                              .update({
                            'videoIndex': 1,
                          });

                          //ŠALJE KOJI VIDEO PUSTUTI NA VIDEO EKRANU
                          FirebaseFirestore.instance
                              .collection('game')
                              .doc('Event')
                              .collection('Events')
                              .doc('Video')
                              .update({
                            'video': 2,
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
                      },
                      child: Text('HEP')),
                )
              ],
            )
          ],
        ));
  }

  Widget EventsContainer() {
    return Center(
      child: Row(
        children: [
          Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 400,
                    width: 200,
                    child: scorerHomeList(),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 400,
                    width: 200,
                    child: ScorerAwayList(),
                  )
                ],
              ),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('game')
                          .doc('Event')
                          .collection('Events')
                          .doc('Cards')
                          .update({
                        'index': 3,
                      });
                    });

                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 800,
                              height: 900,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            setState(() {
                                              FirebaseFirestore.instance
                                                  .collection('game')
                                                  .doc('Event')
                                                  .collection('Events')
                                                  .doc('ShowPlayer')
                                                  .update({
                                                'playerName': '',
                                                'playerSurname': '',
                                                'playerNumber': '',
                                                'playerPicture': '',
                                              });
                                              FirebaseFirestore.instance
                                                  .collection('game')
                                                  .doc('Event')
                                                  .collection('Events')
                                                  .doc('Cards')
                                                  .update({
                                                'index': 0,
                                              });
                                              Timer(Duration(seconds: 1), () {
                                                Navigator.pop(context);
                                              });
                                            });
                                          },
                                          icon: Icon(Icons.close),
                                          label: Text(''))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                          height: 580,
                                          width: 350,
                                          child: PostaveHomeList()),
                                      SizedBox(
                                        width: 100,
                                      ),
                                      SizedBox(
                                          height: 580,
                                          width: 350,
                                          child: postaveAwayList()),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Text('POSTAVE')),
              SizedBox(
                height: 20,
                width: 1,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getSwitch.homeORaway = 'homeClubName';
                      });
                      FireSwitch.update({'videoIndex': 2,}); //postavljem switch da prebaci na prikaz zamjena
                      FireSwitch.update({'video': 1,}); // te odmah nakon toga da prebaci sa prikaza semafora na prikaz zamjena
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 1000,
                              height: 900,
                              child: Column(
                                children: [
                                  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                    ElevatedButton(
              onPressed: (){

              FireSwitch.update({'videoIndex': 0,}); //postavljem switch da prebaci na prikaz zamjena
              FireSwitch.update({'video': 0,}); // te odmah nakon toga da prebaci sa prikaza semafora na prikaz zamjena
              
              FirestoreEvent..doc('ShowPlayer').update({'playerName': '','playerSurname': '','playerNumber': '','playerPicture': '',});
              FirestoreEvent..doc('PlayerIN').update({'playerName': '','playerSurname': '','playerNumber': '','playerPicture': '',});

              Navigator.pop(context);

            }, child: Icon(Icons.close), ),
                                  ],),
                                  Zamjene(),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('ZAMJENA')),
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        getSwitch.homeORaway = 'awayClubName';
                      });
                      FireSwitch.update({'videoIndex': 2,}); //postavljem switch da prebaci na prikaz zamjena
                      FireSwitch.update({'video': 1,}); // te odmah nakon toga da prebaci sa prikaza semafora na prikaz zamjena
                      showDialog(
                        barrierDismissible: false,

                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              width: 1000,
                              height: 900,
                              child: Zamjene(),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      'ZAMJENA GOSTI',
                      style: TextStyle(fontSize: 15),
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
