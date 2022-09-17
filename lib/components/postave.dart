import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';





final CollectionReference postaveUtakmice =
    FirebaseFirestore.instance.collection('clubs');

final CollectionReference igraciUtakmica =
    FirebaseFirestore.instance.collection('players');

final CollectionReference clubData = FirebaseFirestore.instance.collection('game');

class Postave extends StatefulWidget {
  @override
  State<Postave> createState() => PostaveState();
}

class PostaveState extends State<Postave>{
  var selectedClub, selectedAwayClub;


 Future<QuerySnapshot>? firestoreStream;

  @override
  void initState() {
    firestoreStream = postaveUtakmice.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  FutureBuilder<QuerySnapshot>(
                     future: firestoreStream,
                      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
                        if (streamSnapshot.hasData) {
                           List<DropdownMenuItem> clubItems = [];
                          for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                            DocumentSnapshot snapPostave = streamSnapshot.data!.docs[i];
                            clubItems.add(
                              DropdownMenuItem(
                              value: "${snapPostave.get('clubName')}",
                              child: Text(
                                snapPostave.get('clubName'),
                                style: TextStyle(color: Colors.blue),
                              ),
                            ));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.accessibility_new,
                                  size: 25, color: Colors.amber),
                              SizedBox(
                                width: 50,
                              ),
                              DropdownButton(
                                  items: clubItems,
                                  onChanged: (clubValues) {
                                    setState(() {
                                      selectedClub = clubValues;
      
                                      FirebaseFirestore.instance.collection('game').doc('Home').update({'homeClubName': selectedClub, });
                                    });
                                  },
                                  value: selectedClub,
                                  isExpanded: false,
                                  hint: Text(
                                "Choose Club",
                                style: TextStyle(color: Colors.black)),
                                  )
                            ],
                          );
                        } 
      
                        return const Center(
                        child: CircularProgressIndicator(),
            );
                      }),
                
            SizedBox(height: 20,),
   
            
                ],
              ),
              Column(
           

                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                  ),
                                
                                ],
                              ),
              Column(

              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  SizedBox(
                    height: 50,
                  ),
                  FutureBuilder<QuerySnapshot>(
                      future: firestoreStream,
                      builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
                        if (streamSnapshot.hasData) {
                           List<DropdownMenuItem> clubItems = [];
                          for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                            DocumentSnapshot snapPostave = streamSnapshot.data!.docs[i];
                            clubItems.add(
                              DropdownMenuItem(
                              value: "${snapPostave.get('clubName')}",
                              child: Text(
                                snapPostave.get('clubName'),
                                style: TextStyle(color: Colors.blue),
                              ),
                            ));
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.accessibility_new,
                                  size: 25, color: Colors.amber),
                              SizedBox(
                                width: 50,
                              ),
                              DropdownButton(
                                  items: clubItems,
                                  onChanged: (clubValues) {
                             
                        
                                    setState(() {
                                      selectedAwayClub = clubValues;
                                      FirebaseFirestore.instance.collection('game').doc('Away').update({'awayClubName': selectedAwayClub});
                                     
                                    });
                                  },
                                  value: selectedAwayClub,
                                  isExpanded: false,
                                  hint: Text(
                                "Choose Club",
                                style: TextStyle(color: Colors.black)),
                                  )
                            ],
                          );
                        } 
      
                        return const Center(
                        child: CircularProgressIndicator(),
            );
                      }),
                
             SizedBox(height: 20,),
   
                ],
              )
            ],
          ),
      ),
      
    );
  }




}

    String? postaveHomeNumber, postaveHomeName, postaveHomeSurname, postaveHomeURL,selectHome,selectAway;

class PostaveHomeList extends StatefulWidget {
  const PostaveHomeList({super.key});

  @override
  State<PostaveHomeList> createState() => PostaveHomeListState();
}

class PostaveHomeListState extends State<PostaveHomeList> {
    int? _selectedIndexHome;
    


    
  Future<String?> getHome() async {
    var a = await clubData.doc('Home').get();
    setState(() {
      selectHome = a['homeClubName'];
    });
    return selectHome;
  }




  @override
  Widget build(BuildContext context) {

    getHome();
    return Scaffold(
      body: FutureBuilder(
        future: igraciUtakmica
            .where('playerClub', isEqualTo: selectHome).orderBy('playerNumber')
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
                      postaveHomeNumber = documentSnapshot['playerNumber'].toString();
                      postaveHomeSurname = documentSnapshot['playerSurname'];
                      postaveHomeName = documentSnapshot['playerName'];
                      postaveHomeURL = documentSnapshot['playerPicture'];
                
                
                

                  setState(() {
                    showPlayer();
                        });

                     
                    
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




class postaveAwayList extends StatefulWidget {
  const postaveAwayList({super.key});

  @override
  State<postaveAwayList> createState() => postaveAwayListState();
}

class postaveAwayListState extends State<postaveAwayList> {
    int? _selectedIndexAway;
    


    
  Future<String?> getAway() async {
    var a = await clubData.doc('Away').get();
    setState(() {
      selectAway = a['awayClubName'];
    });
    return selectAway;
  }


  @override
  Widget build(BuildContext context) {

    getAway();
    return Scaffold(
      body: FutureBuilder(
        future: igraciUtakmica
            .where('playerClub', isEqualTo: selectAway).orderBy('playerNumber')
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
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
                      postaveHomeNumber = documentSnapshot['playerNumber'].toString();
                      postaveHomeSurname = documentSnapshot['playerSurname'];
                      postaveHomeName = documentSnapshot['playerName'];
                      postaveHomeURL = documentSnapshot['playerPicture'];
                
                
                

                  setState(() {
                    showPlayer();
                        });

                     
                    
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

      Future<void> showPlayer() {
      // Call the user's CollectionReference to add a new user
      return clubData.doc('Event').collection('Events').doc('ShowPlayer').set({
            'playerNumber': postaveHomeNumber, 
            'playerName': postaveHomeName, 
            'playerSurname': postaveHomeSurname, 
            'playerPicture': postaveHomeURL, 
          

          });
    }





