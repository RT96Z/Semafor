import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireStorePlayersDataBase {



  List playersList = [];
  final CollectionReference playersData =
      FirebaseFirestore.instance.collection("players");

   Future getData() async {
    try {
      //to get data from a single/particular document alone.
      // var temp = await collectionRef.doc("<your document ID here>").get();

      // to get data from all documents sequentially
      await playersData.get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          playersList.add(result.data());
        }
      });

      return playersList;
    } catch (e) {
      debugPrint("Error - $e");
      return null;
    }
  }


   
}


class playersDataList extends StatefulWidget {
  const playersDataList({Key? key}) : super(key: key);

  @override
  _playersDataListState createState() => _playersDataListState();
}

class _playersDataListState extends State<playersDataList> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: FireStorePlayersDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              "Something went wrong",
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: SizedBox(
            width: 20,
            child: Row(
              children: [
                Text(
                  dataList[index]["playerName"],
                ),
                SizedBox(width: 10,),
                Text(
                  dataList[index]["playerSurname"],
                ),
              ],
            ),
          ),
          subtitle:  Text(dataList[index]["playerClub"]),
          trailing: Text(
            dataList[index]["playerNumber"],
          ),
        );
      });
}

