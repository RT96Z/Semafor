import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/text_field_decoration.dart';
import 'dart:async';


final CollectionReference igraciUtakmica = FirebaseFirestore.instance.collection('players');
final CollectionReference clubData = FirebaseFirestore.instance.collection('game');


  final goalMinute = TextEditingController();

  String? selectedPlayer,selectedClub,homePlayers;


class gamePlayersHomeList extends StatefulWidget {
  const gamePlayersHomeList({super.key});

  @override
  State<gamePlayersHomeList> createState() => gamePlayersHomeListState();
}

class gamePlayersHomeListState extends State<gamePlayersHomeList> {
    int? _selectedIndexHome;
  Future<String?> getHome() async {
    var a = await clubData.doc('Score').get();
    setState(() {
      homePlayers = a['homeClubName'];
    });
    return homePlayers;
  }

   Future <QuerySnapshot>? firestoreStream;

  @override
  void initState() {
   
   
    Timer(Duration(seconds: 1), () {
    firestoreStream = igraciUtakmica
            .where('playerClub', isEqualTo: homePlayers).orderBy('playerNumber')
            .get();
             });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

     getHome();
    return Scaffold(
      body: FutureBuilder(
        future: firestoreStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  
                  margin: const EdgeInsets.all(1),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                                      documentSnapshot['playerNumber'].toString(),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  
                    ),
                            
                    title: SizedBox(
                        child: Row(
                      children: [

                        const SizedBox(
                          width: 25,
                        ),
                        Row(
                          children: [
                            Text(documentSnapshot['playerName']),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(documentSnapshot['playerSurname']),
                          ],
                        ),
                      ],
                    )),
  
                    selected: index == _selectedIndexHome,
                    onTap: () {
                      _selectedIndexHome = index;
                      selectedPlayer = documentSnapshot['playerSurname'];
                      selectedClub = documentSnapshot['playerClub'];
         
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class gamePlayersAwayList extends StatefulWidget {
  const gamePlayersAwayList({super.key});

  @override
  State<gamePlayersAwayList> createState() => gamePlayersAwayListState();
}

class gamePlayersAwayListState extends State<gamePlayersAwayList> {
      int _selectedIndexAway = 0;

  String? awayPlayers;
  Future<String?> getAway() async {
    var b = await clubData.doc('Score').get();
    setState(() {
      awayPlayers = b['awayClubName'];
    });
    return awayPlayers;
  }

   Future <QuerySnapshot>? firestoreStream;

  @override
  void initState() {
      Timer(Duration(seconds: 1), () {
    firestoreStream = igraciUtakmica
            .where('playerClub', isEqualTo: awayPlayers).orderBy('playerNumber')
            .get();
      });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    getAway();
    return Scaffold(
      body: FutureBuilder(
        future: firestoreStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
           return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  
                  margin: const EdgeInsets.all(1),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                                      documentSnapshot['playerNumber'].toString(),
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  
                    ),
                            
                    title: SizedBox(
                        child: Row(
                      children: [

                        const SizedBox(
                          width: 25,
                        ),
                        Row(
                          children: [
                            Text(documentSnapshot['playerName']),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(documentSnapshot['playerSurname']),
                          ],
                        ),
                      ],
                    )),
  
                    selected: index == _selectedIndexAway,
                    onTap: () {
                      _selectedIndexAway = index;
                      selectedPlayer = documentSnapshot['playerSurname'];
                      selectedClub = documentSnapshot['playerClub'];
         
                    },
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class eventTrack extends StatefulWidget {
  const eventTrack({super.key});

  @override
  State<eventTrack> createState() => _eventTrackState();
}

class _eventTrackState extends State<eventTrack> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
              width: 100,
              height: 50,
              child: TextField(
                style: TextStyle(
                  color: Colors.black,
                 
                ),
                 decoration: InputDecoration(
                   hintText: 'min. gola',
                  filled: true,
                  fillColor: Colors.blueGrey[100],
                  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  )
                 ),
                controller: goalMinute,
                
              )),
                 SizedBox(height: 1,width: 15,),
          SizedBox(
            height: 50, width: 100,
            child: ElevatedButton.icon(onPressed: () {
              // ako klub odabranog igraca je = domaćem klubu onda bi značilo da domaći klub zabio i da se treba dodati na listu domaćih strijelaca.
              if( selectedClub == homePlayers ){
                setState(() {
                  addHomeEvent();
                });
                
              }
              // u suprotnom znači da je odabrani igrač gostujući i da ide na listu gostujućih strijelaca
              else { setState(() {
                addAwayEvent();
              }); }
              goalMinute.clear();
            }, label: Text('Gol', style: settingsTextStyle,),
            icon: Icon(Icons.sports_football),
            ),
          )
        ],
      ),
    );
  }
}


Future<void> addAwayEvent() {
      // Call the user's CollectionReference to add a new user
      return clubData.doc('Event').collection('awayEvent')
          .add({
            'scorer': selectedPlayer, 
            'goalMinute': goalMinute.text, 

          });
    }

    Future<void> addHomeEvent() {
      // Call the user's CollectionReference to add a new user
      return clubData.doc('Event').collection('homeEvent')
          .add({
            'scorer': selectedPlayer, 
            'goalMinute': goalMinute.text, 

          });
    }