import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/components/drop_down_clubs.dart';


class playersDataList extends StatefulWidget {
  const playersDataList({Key? key}) : super(key: key);

  @override
  playersDataListState createState() => playersDataListState();
}

class playersDataListState extends State<playersDataList> {
// text fields' controllers

  final TextEditingController _playerNumberController = TextEditingController();
  final TextEditingController _playerNameController = TextEditingController();
  final TextEditingController _playerSurnameController =
      TextEditingController();
  final TextEditingController _playerClubController = TextEditingController();

  final CollectionReference _players =
      FirebaseFirestore.instance.collection('players');

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _playerNumberController.text = documentSnapshot['playerNumber'];
      _playerNameController.text = documentSnapshot['playerName'];
      _playerSurnameController.text = documentSnapshot['playerSurname'];
      _playerClubController.text = documentSnapshot['playerClub'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  controller: _playerNameController,
                  decoration: const InputDecoration(labelText: 'PlayerName'),
                ),
                TextField(
                  controller: _playerSurnameController,
                  decoration: const InputDecoration(labelText: 'PlayerSurname'),
                ),
                TextField(
                  controller: _playerNumberController,
                  decoration: const InputDecoration(
                    labelText: 'playerNumber',
                  ),
                ),
          SizedBox(
                  height: 40,
                  width: 250,
                  child:  DropDownClubs(),
                ),
      

                const SizedBox(
                  height: 20,
                ),
                
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String PlayerName = _playerNameController.text;
                    final String PlayerSurname = _playerSurnameController.text;
                    final String PlayerNumber = _playerNumberController.text;
                    final String PlayerClub = _playerClubController.text;
                    if (PlayerNumber != null) {
                      await _players.doc(documentSnapshot!.id).update({
                        "playerbName": PlayerName,
                        'playerSurname': PlayerSurname,
                        "playerNumber": PlayerNumber,
                        'playerClub': dataOfPlayers.club
                      });
                      setState(() {

                    });
                      _playerNameController.text = '';
                      _playerNumberController.text = '';
                      Navigator.of(context).pop();
                    }
                    
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String clubId) async {
    await _players.doc(clubId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have successfully deleted a player')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _players.where('playerClub', isEqualTo: dataOfPlayers.club).orderBy('playerNumber')
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
                  child: Row(
                    children: [
                      SizedBox(width: 15,),

                            Container(
                              height: 50.0,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.circle,
                                      color: Colors.blue,
                                      size: 50.0,
                                    ),
                                    Text(
                                      documentSnapshot['playerNumber'].toString(),
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          
                       const SizedBox(
                          width: 15,
                        ),


                       SizedBox(
                          width: 150,
                          height: 50,
                          child:  Center(
                                      child: Text(documentSnapshot['playerName']) ,
                                    )
                        ),
                           
                            SizedBox(
                              width: 5,
                            ),
                       SizedBox(
                          width: 150,
                          height: 50,
                          child: Center(
                                      child: Text(documentSnapshot['playerSurname']),
                                    )  
                        ),
                           
                     SizedBox(
                          width: 150,
                          height: 50,
                          child:  Center(
                                      child: Text(documentSnapshot['playerClub']),
                                    )  
                        ),

                    SizedBox(width: 100,),
                     SizedBox(
                          width: 150,
                          height: 100,
                          child:  Center(
                                      child:
                                     
                                      documentSnapshot['playerPicture'] != null ? Image.network('${documentSnapshot['playerPicture']}', fit: BoxFit.cover) : 
                                      Image.asset(
                                            'assets/pic/defaultPlayer.png',
                                            fit: BoxFit.cover,
                                          ),
                                    )  
                        ),
     
                  Flexible(
                     flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _update(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _delete(documentSnapshot.id)),
                        ],
                      ),
                    )]
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

