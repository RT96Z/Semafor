import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:semafor/components/time.dart';

import 'package:semafor/firebase/scorer_list.dart';

String? download, Home;
var downloadHome, downloadAway, HomeLink;

final CollectionReference clubData =
    FirebaseFirestore.instance.collection('game');

class PublicScoreboardScreen extends StatefulWidget {
  const PublicScoreboardScreen({super.key});

  @override
  State<PublicScoreboardScreen> createState() => _PublicScoreboardScreenState();
}

class _PublicScoreboardScreenState extends State<PublicScoreboardScreen> {
  String? homeName, awayName;
  int indexPosition = 0;

  Future<String?> getHomeData() async {
    var a = await clubData.doc('Home').get();

    setState(() {
      homeName = a['homeClubName'];
    });
    return homeName;
  }

  Future<String?> getAwayData() async {
    var b = await clubData.doc('Away').get();
    setState(() {
      awayName = b['awayClubName'];
    });
    return awayName;
  }

  Future<String?> getIndex() async {
    var b = await clubData.doc('Event').collection('Events').doc('Cards').get();
    setState(() {
      indexPosition = b['index'];
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    getAwayData();
    getHomeData();
    getIndex();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            IndexedStack(
              index: indexPosition,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // stupac za domaći tim (golovi, grb, zapisnik)
                      Column(
                        children: [
                          // red za grb i golove domaćeg tima
                          Row(
                            children: [
                              // Container za ime kluba i grb
                              Column(
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: FutureBuilder<DocumentSnapshot>(
                                          future: clubData.doc('Home').get(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return new Text("Loading");
                                            } else {
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;
                                              return Text(
                                                "${data['homeClubName']}",
                                                style: TextStyle(
                                                    height: 2,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                                textAlign: TextAlign.start,
                                              );
                                            }
                                          })),
                                  FutureBuilder(
                                      future: getHomePicture(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Container(
                                            height: 150,
                                            width: 150,
                                            child: Image.network(
                                              downloadHome.toString(),
                                              height: 150,
                                              width: 150,
                                            ),
                                          );
                                        }
                                      })
                                ],
                              ),
                              Container(
                                  height: 300,
                                  width: 300,
                                  child: FutureBuilder<DocumentSnapshot>(
                                      future: clubData.doc('Home').get(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Text("Loading");
                                        } else {
                                          Map<String, dynamic> data =
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>;
                                          return Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${data['goals']}",
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }
                                      }))
                            ],
                          ),
                          // red za zapisnik domaćeg tima
                          Row(
                            children: [
                              Container(
                                height: 400,
                                width: 600,
                                child: scorerHomeList(),
                              )
                            ],
                          )
                        ],
                      ),
                      //stupac za dvotočje/crticu i vrijeme
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            ' : ',
                            style: TextStyle(
                                height: 2, fontSize: 90, color: Colors.white),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                              height: 100,
                              width: 100,
                              child: ShowTime())
                        ],
                      ),
                      // stupac za gostujući tim (golovi, grb, zapisnik)
                      Column(
                        children: [
                          // red za grb i gostujućeg domaćeg tima
                          Row(
                            children: [
                              // Container za ime kluba i grb

                              Container(
                                  height: 300,
                                  width: 300,
                                  child: FutureBuilder<DocumentSnapshot>(
                                      future: clubData.doc('Away').get(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return new Text("Loading");
                                        } else {
                                          Map<String, dynamic> data =
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>;
                                          return Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "${data['goals']}",
                                              style: TextStyle(
                                                  fontSize: 100,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }
                                      })),

                              Column(
                                children: [
                                  Container(
                                      height: 100,
                                      width: 100,
                                      child: FutureBuilder(
                                          future: clubData.doc('Away').get(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Text("Loading");
                                            } else {
                                              Map<String, dynamic> data =
                                                  snapshot.data!.data()
                                                      as Map<String, dynamic>;
                                              return Text(
                                                "${data['awayClubName']}",
                                                style: TextStyle(
                                                    height: 2,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                                textAlign: TextAlign.start,
                                              );
                                            }
                                          })),
                                  FutureBuilder(
                                      future: getAwayPicture(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else {
                                          return Container(
                                            height: 150,
                                            width: 150,
                                            child: Image.network(
                                              downloadAway.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        }
                                      })
                                ],
                              ),
                            ],
                          ),
                          // red za zapisnik gostujućeg tima
                          Row(
                            children: [
                              Container(
                                height: 400,
                                width: 600,
                                child: scorerAwayList(),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        'assets/zuti.png',
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: Center(
                      child: Image.asset(
                        'assets/crveni.png',
                        fit: BoxFit.fitWidth,
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getHomePicture() async {
    try {
      await downloadHomeURL();
      return downloadHome;
    } catch (e) {
      debugPrint('Error - $e');
      return null;
    }
  }

  Future<void> downloadHomeURL() async {
    downloadHome = await FirebaseStorage.instance
        .ref('Clubs')
        .child('$homeName')
        .getDownloadURL();
  }

  Future getAwayPicture() async {
    try {
      await downloadAwayURL();
      return downloadAway;
    } catch (e) {
      debugPrint('Error - $e');
      return null;
    }
  }

  Future<void> downloadAwayURL() async {
    downloadAway = await FirebaseStorage.instance
        .ref('Clubs')
        .child('$awayName')
        .getDownloadURL();
  }

  Time() async {}
}
