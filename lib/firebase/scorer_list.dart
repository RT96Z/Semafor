import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/colors.dart';

final CollectionReference gameData =
    FirebaseFirestore.instance.collection('game');

class scorerHomeList extends StatefulWidget {
  const scorerHomeList({super.key});

  @override
  State<scorerHomeList> createState() => scorerHomeListState();
}

class scorerHomeListState extends State<scorerHomeList> {
  Future<void> _delete(String clubId) async {
    await gameData.doc('Event').collection('homeEvent').doc(clubId).delete();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: FutureBuilder(
        future: gameData
            .doc('Event')
            .collection('homeEvent')
            .orderBy('goalMinute')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return  ListTile(
                      title: Row(
                        children: [
                          Text(documentSnapshot['goalMinute'],
                              style: scorerListPureWhite),
                          Text("' - ", style: scorerListPureWhite),
                          SizedBox(
                            width: 5,
                          ),
                          Text(documentSnapshot['scorer'],
                              style: scorerListPureWhite),
                        ],
                      ),
                      onLongPress: () {
                        _delete(documentSnapshot.id);
                      });

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

class scorerAwayList extends StatefulWidget {
  const scorerAwayList({super.key});

  @override
  State<scorerAwayList> createState() => scorerAwayListState();
}

class scorerAwayListState extends State<scorerAwayList> {
  Future<void> _delete(String clubId) async {
    await gameData.doc('Event').collection('awayEvent').doc(clubId).delete();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: FutureBuilder(
        future: gameData
            .doc('Event')
            .collection('awayEvent')
            .orderBy('goalMinute')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                                return Container(
                  // height: MediaQuery.of(context).size.height,


                  child: ListTile(
                    
                      title: Row(
                        children: [
                          Text(documentSnapshot['goalMinute'],
                              style: scorerListPureWhite),
                          Text("' - ", style: scorerListPureWhite),
                          SizedBox(
                            width: 5,
                          ),
                          Text(documentSnapshot['scorer'],
                              style: scorerListPureWhite),
                        ],
                      ),
                      onLongPress: () {
                        _delete(documentSnapshot.id);
                      }),
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
