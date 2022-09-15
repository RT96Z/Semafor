import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/components/playerListclass.dart';

final CollectionReference igraciUtakmica =
    FirebaseFirestore.instance.collection('players');
final CollectionReference clubData =
    FirebaseFirestore.instance.collection('game');

class ReorderPlayerHomeLIst extends StatefulWidget {
  @override
  State<ReorderPlayerHomeLIst> createState() => _ReorderPlayerHomeLIstState();
}

class _ReorderPlayerHomeLIstState extends State<ReorderPlayerHomeLIst> {
  List<Object> playersHomeList = [];
    List<Object> copyListHome=[];
  String? homeName;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getHomeData();
    Timer(Duration(milliseconds: 1000), () {
      //najlijenije riješenje ikad
      getHomePlayer();
    });
  }

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
        body: Column(
          children: [
            Container(
      height: MediaQuery.of(context).size.height,
      width: 400,
      child: ReorderableListView.builder(
            itemCount: playersHomeList.length,
            itemBuilder: (context, index) {
              final user = playersHomeList[index];
              return ListTilePlayers().buildPlayer(index, user as PlayersList);

            },
            onReorder: ((oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = playersHomeList.removeAt(oldIndex);
                playersHomeList.insert(newIndex, item);
               
              });
            }),
      ),
    ),
       
    SizedBox(height: 20,),


    ElevatedButton(onPressed: (){
      playersHomeList = [...playersHomeList];
      
    }, child: Text('Save')),

    SizedBox(height: 20,),


    ElevatedButton(onPressed: (){
     
      print(copyListHome[1]);
    }, child: Text('Print')),

          ],
        ));
  }




  Future<String?> getHomeData() async {
    var a = await clubData.doc('Home').get();

    setState(() {
      homeName = a['homeClubName'];
    });
    return homeName;
  }

  Future getHomePlayer() async {
    var data = await FirebaseFirestore.instance
        .collection('players')
        .where('playerClub', isEqualTo: homeName)
        .orderBy('playerNumber')
        .get();

    setState(() {
      playersHomeList =
          List.from(data.docs.map((doc) => PlayersList.fromSnapshot(doc)));
    });
  }
}

class ReorderPlayerAwayLIst extends StatefulWidget {
  @override
  State<ReorderPlayerAwayLIst> createState() => _ReorderPlayerAwayLIstState();
}

class _ReorderPlayerAwayLIstState extends State<ReorderPlayerAwayLIst> {
  List<Object> playersAwayList = [];
  String? homeName;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getAwayData();
    Timer(Duration(seconds: 1), () {
      //najlijenije riješenje ikad
      getAwayPlayer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
           
      height: MediaQuery.of(context).size.height,
      width: 400,
      child: ReorderableListView.builder(
            itemCount: playersAwayList.length,
            itemBuilder: (context, index) {
              final user = playersAwayList[index];
              return ListTilePlayers().buildPlayer(index, user as PlayersList);
            },
            onReorder: ((oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = playersAwayList.removeAt(oldIndex);
                playersAwayList.insert(newIndex, item);
              });
            }),
      ),
    ),
    
    
    SizedBox(height: 20,),


    ElevatedButton(onPressed: (){
      List<Object> copyListAway = [...playersAwayList];
      
    }, child: Text('Save'))
          ],
        ),
    
    
    
    
    );
  }

  Future<String?> getAwayData() async {
    var a = await clubData.doc('Away').get();

    setState(() {
      homeName = a['awayClubName'];
    });
    return homeName;
  }

  Future getAwayPlayer() async {
    var data = await FirebaseFirestore.instance
        .collection('players')
        .where('playerClub', isEqualTo: homeName)
        .orderBy('playerNumber')
        .get();

    setState(() {
      playersAwayList =
          List.from(data.docs.map((doc) => PlayersList.fromSnapshot(doc)));
    });
  }
}

class ListTilePlayers {
  @override
  Widget buildPlayer(int index, PlayersList playerList) => Card(
        margin: const EdgeInsets.all(1),
        key: ValueKey(playerList),
        child: ListTile(
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
