

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

final CollectionReference showFromBase =
    FirebaseFirestore.instance.collection('game');

class ShowReplacements extends StatefulWidget {
  const ShowReplacements({super.key});

  @override
  State<ShowReplacements> createState() => _ShowReplacementsState();
}

class _ShowReplacementsState extends State<ShowReplacements> {
  String? playerOUTName,
      playerOUTSurname,
      playerOUTNumber,
      playerOUTPicture,
      playerINName,
      playerINSurname,
      playerINNumber,
      playerINPicture;

  Future<String?> getPlayerData() async {
    var a = await showFromBase
        .doc('Event')
        .collection('Events')
        .doc('ShowPlayer')
        .get();
    var b = await showFromBase
        .doc('Event')
        .collection('Events')
        .doc('PlayerIN')
        .get();

    setState(() {
      playerOUTName = a['playerName'];
      playerOUTSurname = a['playerSurname'];
      playerOUTNumber = a['playerNumber'].toString();
      playerOUTPicture = a['playerPicture'];

      playerINName = b['playerName'];
      playerINSurname = b['playerSurname'];
      playerINNumber = b['playerNumber'].toString();
      playerINPicture = b['playerPicture'];
    });
    return playerOUTName;
  }

  @override
  Widget build(BuildContext context) {
    getPlayerData();
    return Scaffold(
      body:
            // SLIKA IGRAČA
    
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: 1,
              ),
              // SLIKA I BROJ IGRACA KOJI IZLAZI
              Row(
                children: [
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: playerOUTPicture != null
                        ? Image.network('$playerOUTPicture}', fit: BoxFit.cover)
                        :
                        // Image.asset('assets/pic/defaultPlayer.png', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
                        Text(''),
                  ),
    
                  SizedBox(
                    width: 20,
                    height: 1,
                  ),
    
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: Text(
                        playerOUTNumber.toString(),
                        style: TextStyle(fontSize: 80, color: Colors.white),
                      ),
                    ),
                  ) // OVDJE IDE BROJ
                ],
              ),
    
              SizedBox(
                height: 20,
                width: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 70,
                      child:  Text(
                          textAlign: TextAlign.start,
                          '$playerOUTName',
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ),
                ],
              ),
              SizedBox(
                height: 5,
                width: 1,
              ),
              SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 80,
                    child:  Text(
                      textAlign: TextAlign.end,
                        '$playerOUTSurname',
                        style: TextStyle(fontSize: 60, color: Colors.white),
                      ),
                    ),
              
            ],
          ),
          // STUPAC ZA STRELICE --> i <--
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
    SizedBox(
                    width: 300,
                    height: 300,
                    child: 
                         Image.asset('assets/pic/subGif.gif', fit: BoxFit.cover,),  
                       
                  ),
    
            ],
          ),
          //STUPAC ZA IME I BROJ IGRAČA KOJI ULAZI
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
                width: 1,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 150,
                    child: Center(
                      child: Text(
                        playerINNumber.toString(),
                        style: TextStyle(fontSize: 80, color: Colors.white),
                      ),
                    ),
                  ), // OVDJE IDE
                  SizedBox(
                    width: 20,
                    height: 1,
                  ),
                  SizedBox(
                    width: 350,
                    height: 350,
                    child: playerINPicture != null
                        ? Image.network('$playerINPicture}', fit: BoxFit.cover)
                        :
                        // Image.asset('assets/pic/defaultPlayer.png', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
                        Text(''),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
                width: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 70,
                      child:  Text(
                        textAlign: TextAlign.end,
                          '$playerINName',
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                      ),
                ],
              ),
              SizedBox(
                height: 5,
                width: 1,
              ),
              Row(

                children: [

                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: 80,
                      child: Text(
                        textAlign: TextAlign.start,
                          '$playerINSurname',
                          style: TextStyle(fontSize: 60, color: Colors.white),
                        ),
                      ),
                ],
              ),
            ],
          ),
    
        ]),
      
    );
  }
}
