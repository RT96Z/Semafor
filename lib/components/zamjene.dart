import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:semafor/screens/playerListclass.dart';

    String? zamjenaINNumber, zamjenaINName, zamjenaINSurname, zamjenaINURL,selectIN,selectOUT,zamjenaOUTNumber, zamjenaOUTName, zamjenaOUTSurname, zamjenaOUTURL;
         int? _selectedIndexIN, selectedIndexOUT;

final CollectionReference igraciUtakmica =
    FirebaseFirestore.instance.collection('players');
final CollectionReference clubData =
    FirebaseFirestore.instance.collection('game');


class getSwitch{

    static String? homeORaway;
}

class Zamjene extends StatefulWidget {
  const Zamjene({super.key});

  @override
  State<Zamjene> createState() => _ZamjeneState();
}

class _ZamjeneState extends State<Zamjene> {

  List<Object> playersOUTList = [];
  String? selectedClubName;

  @override
  void didChangeDependencies() {
    
    super.didChangeDependencies();
    getOUTData();
    Timer(Duration(seconds: 1), () {
      //najlijenije riješenje ikad
      getOUTPlayer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(children: [
      //Igrač koji izlazi
      Column(
        children: [
                Container(
           
      height: 800,
      width: 400,
      child: ListView.builder(
      itemCount: playersOUTList.length,
      itemBuilder: (context, index) {
              final user = playersOUTList[index];
              return ListTilePlayers().buildOUTPlayers(index, user as PlayersList);
            },
          
      ),
    ),



        ],
      ),
      SizedBox(
        width: 50,
        height: 1,
      ),
      // Igrač koji ulazi
      Column(children: [
      Container(
           
      height: 800,
      width: 400,
      child: ListView.builder(
            itemCount: playersOUTList.length,
            itemBuilder: (context, index) {
              final user = playersOUTList[index];
              return ListTilePlayers().buildINPlayers(index, user as PlayersList);
            },
          
      ),
    ),
    

      ]),

      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox( width: 100, height: 50, child: ElevatedButton(
            
            child: Text('Prikazi'),
            onPressed: (){
            showPlayerIN();
            showPlayerOUT();
          }),)
        ],
      )
    
    
    ])
    
    
    );
  }

   Future<String?> getOUTData() async {
    var a = await clubData.doc('Home').get();

    setState(() {
      selectedClubName = a['${getSwitch.homeORaway}'];
    });
    return selectedClubName;
  }
//Punjenje liste sa podatcima igrača odabranog kluba
  Future getOUTPlayer() async {
    var data = await FirebaseFirestore.instance.collection('players').where('playerClub', isEqualTo: selectedClubName).orderBy('playerNumber').get();

    setState(() {
      playersOUTList =
          List.from(data.docs.map((doc) => PlayersList.fromSnapshot(doc)));
    });
  }
}
//TODO: ovako si mogu stavljati podsjetnike za kasnije
class ListTilePlayers {

 
  @override
  Widget buildOUTPlayers(int index, PlayersList playerList) => Card(
        margin: const EdgeInsets.all(1),
        key: ValueKey(playerList),
        child: ListTile(
          selected: index == selectedIndexOUT,
          onTap: () {
            selectedIndexOUT = index;
            zamjenaOUTNumber = playerList.number.toString();
            zamjenaOUTSurname = playerList.surname;
            zamjenaOUTName = playerList.name;
            zamjenaOUTURL = playerList.playerPic;
            
          },
          leading: CircleAvatar(
            child: Text(
              '${playerList.number}',
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          title: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${playerList.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${playerList.surname}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );


      @override
  Widget buildINPlayers(int index, PlayersList playerList) => Card(
        margin: const EdgeInsets.all(1),
        key: ValueKey(playerList),
        child: ListTile(
          selected: index == _selectedIndexIN,
          onTap: () {
            _selectedIndexIN = index;
            zamjenaINNumber = playerList.number.toString();
            zamjenaINSurname = playerList.surname;
            zamjenaINName = playerList.name;
            zamjenaINURL = playerList.playerPic;
            
          },
          leading: CircleAvatar(
            child: Text(
              '${playerList.number}',
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          title: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${playerList.name}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  '${playerList.surname}',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
}

      Future<void> showPlayerOUT() {
//Koristim vezu za prikaz igrača jer je sve isto 
      return clubData.doc('Event').collection('Events').doc('ShowPlayer').set({
            'playerNumber': zamjenaOUTNumber, 
            'playerName': zamjenaOUTName, 
            'playerSurname': zamjenaOUTSurname, 
            'playerPicture': zamjenaOUTURL, 
          

          });
    }

      Future<void> showPlayerIN() {
      return clubData.doc('Event').collection('Events').doc('PlayerIN').set({
            'playerNumber': zamjenaINNumber, 
            'playerName': zamjenaINName, 
            'playerSurname': zamjenaINSurname, 
            'playerPicture': zamjenaINURL, 
          

          });
    }
    
