import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

final CollectionReference showFromBase =FirebaseFirestore.instance.collection('game');

class ShowPlayers extends StatefulWidget {
  const ShowPlayers({super.key});

  @override
  State<ShowPlayers> createState() => _ShowPlayersState();
}

class _ShowPlayersState extends State<ShowPlayers> {
  String? playerName, playerSurname, playerNumber, playerPicture;

  Future<String?> getPlayerData() async {
    var a = await showFromBase
        .doc('Event')
        .collection('Events')
        .doc('ShowPlayer')
        .get();

    setState(() {
      playerName = a['playerName'];
      playerSurname = a['playerSurname'];
      playerNumber = a['playerNumber'].toString();
      playerPicture = a['playerPicture'];
    });
    return playerName;
  }

  @override
  Widget build(BuildContext context) {
    getPlayerData();
    return Container(
  
      height: 600,
      width: 900,
      child:
          // SLIKA IGRAČA

           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          
              children: [
                  
                  Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              
                              children: [
                                SizedBox(
                                  width: 450,
                                  height: 550,
                                  child:
                        playerPicture != null
                      ? Image.network('$playerPicture}', fit: BoxFit.cover)  :
                       // Image.asset('assets/pic/defaultPlayer.png', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
                       Text(''),
                                ),
                              ],
                    ),
                  
                 Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                            
                                    Row(
                                                               mainAxisAlignment: MainAxisAlignment.end,
                                                               
                                                       children: [
                                                               
                                                         Text(
                                                           playerNumber.toString(),
                                                                    
                                                           style: TextStyle(fontSize: 100, color: Colors.white),
                                                         ),
                                                       ],
                                                                     ),
                                   
                                
                                SizedBox(
                             
                                  height: 20,
                                  width: 20,
                                ),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                    
                                                    
                                                    SizedBox(
                                                      
                                                        width: 200,
                                                        height: 100,
                                                        child: Center(
                                                          child: Text(
                                                          '$playerName',
                                                             
                                                           style: TextStyle(fontSize: 58, color: Colors.white),),
                                                        )),

                                                          SizedBox(width: 250,)
                                    ],
                                  ),
                                
   
                                 Row(
                                    children: [
                                                       SizedBox(
    
                                                        height: 20,
                                                        width: 250,
                                                      ),
                                                    SizedBox(
                                                        width: 200,
                                                        height: 100,
                                                        child: Center(
                                                          child: Text(
                                                            '$playerSurname',
                                                           
                                                             style: TextStyle(fontSize: 58, color: Colors.white),),
                                                        )),
                                                        SizedBox(height: 20,)
                                    ],
                                  ),
                                
                              ],
                    ),
                  
                ]),
          

      // BROJ IGRAČA, IME I PREZIME
    );
  }
}
