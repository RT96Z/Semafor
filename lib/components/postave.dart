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



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                FutureBuilder<QuerySnapshot>(
                   future: postaveUtakmice.get(),
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
              
          
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                ),
                                ElevatedButton(onPressed: (){

                            //     FirebaseFirestore.instance.collection('game').doc('Home').update({'homeClubName': clubForHome});
                            //      FirebaseFirestore.instance.collection('game').doc('Away').update({'awayClubName': clubForAway});
                                }, child: Text("Save"))
                              ],
                            ),
            Column(
              children: [
                
                SizedBox(
                  height: 50,
                ),
                FutureBuilder<QuerySnapshot>(
                    future: postaveUtakmice.get(),
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
                           
                      // OvDJE ROKNI DA UPDATEA LINK OD KLUBA NA GOSTUJUĆI KLUB 
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
              
          
              

              ],
            )
          ],
        ),
      ),
    );
  }




}







