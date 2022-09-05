import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<String?> getHome() async {
    var a = await clubData.doc('Home').get();
    setState(() {
      homePlayers = a['homeClubName'];
    });
    return homePlayers;
  }

  @override
  Widget build(BuildContext context) {
    getHome();
    return Scaffold(
      body: FutureBuilder(
        future: igraciUtakmica
            .where('playerClub', isEqualTo: homePlayers)
            .get(),
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
                    title: SizedBox(
                        child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 50.0,
                                    ),
                                    Text(
                                      documentSnapshot['playerNumber'],
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 15,
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
                    subtitle: Text(documentSnapshot['playerClub']),
                    selected: false,
                    onLongPress: () {
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
  

  String? awayPlayers;
  Future<String?> getAway() async {
    var b = await clubData.doc('Away').get();
    setState(() {
      awayPlayers = b['awayClubName'];
    });
    return awayPlayers;
  }

  @override
  Widget build(BuildContext context) {
    getAway();
    return Scaffold(
      body: FutureBuilder(
        future: igraciUtakmica
            .where('playerClub', isEqualTo: awayPlayers)
            .get(),
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
                    title: SizedBox(
                        child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50.0,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    const Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 50.0,
                                    ),
                                    Text(
                                      documentSnapshot['playerNumber'],
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Row(
                          children: [
                            Text(documentSnapshot['playerName']),
                            SizedBox(
                              width: 5,
                            ),
                            Text(documentSnapshot['playerSurname']),
                          ],
                        ),
                      ],
                    )),
                    subtitle: Text(documentSnapshot['playerClub']),
                    selected: false,
                    onLongPress: () {
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
                controller: goalMinute,
              )),
          ElevatedButton(onPressed: () {
            // ako klub odabranog igraca je = domaćem klubu onda bi značilo da domaći klub zabio i da se treba dodati na listu domaćih strijelaca.
            if( selectedClub == homePlayers ){
              addHomeEvent();
            }
            // u suprotnom znači da je odabrani igrač gostujući i da ide na listu gostujućih strijelaca
            else {  addAwayEvent();}
            goalMinute.clear();
          }, child: Text('Gol'))
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