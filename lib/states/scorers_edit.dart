import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/colors.dart';
import 'package:semafor/text_field_decoration.dart';

final CollectionReference gameData =
    FirebaseFirestore.instance.collection('game');

class ScorerEditHome extends StatefulWidget {
  const ScorerEditHome({super.key});

  @override
  State<ScorerEditHome> createState() => ScorerEditHomeState();
}

class ScorerEditHomeState extends State<ScorerEditHome> {
  Future<void> _delete(String clubId) async {
    await gameData.doc('Event').collection('homeEvent').doc(clubId).delete();
  }



  

  @override
  void initState() {
    
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: FutureBuilder(
        future:  gameData
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
                              style: scorersEditStyle),
                          Text("' - ", style: scorersEditStyle),
                          SizedBox(
                            width: 5,
                          ),
                          Text(documentSnapshot['scorer'],
                              style: scorersEditStyle),
                        ],
                      ),
                      trailing: ElevatedButton(child:  Icon(Icons.close, color: Colors.red, size: 20,), onPressed: () {
                        _delete(documentSnapshot.id);
                      },)
                      
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

class ScorerEditAway extends StatefulWidget {
  const ScorerEditAway({super.key});

  @override
  State<ScorerEditAway> createState() => ScorerEditAwayState();
}

class ScorerEditAwayState extends State<ScorerEditAway> {
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(documentSnapshot['goalMinute'],
                              style: scorersEditStyle),
                          Text("' - ", style: scorersEditStyle),
                          SizedBox(
                            width: 5,
                          ),
                          Text(documentSnapshot['scorer'],
                              style: scorersEditStyle),
                        ],
                      ),
                      trailing:ElevatedButton(child:  Icon(Icons.close, color: Colors.red, size: 20,), onPressed: () {
                        _delete(documentSnapshot.id);
                      },)
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
