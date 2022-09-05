import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/colors.dart';


final CollectionReference gameData = FirebaseFirestore.instance.collection('game');




class scorerHomeList extends StatefulWidget {
 const scorerHomeList({super.key});

  

  @override
  State<scorerHomeList> createState() => scorerHomeListState();
}

class scorerHomeListState extends State<scorerHomeList> {
 


  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
      body: FutureBuilder(
        future: gameData.doc('Event').collection('homeEvent').orderBy('goalMinute').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return  Container(
                  // height: MediaQuery.of(context).size.height,
                    color: Colors.black,
                    child: ListTile(

                        title:  
                            Row(
                              children: [
                                Text(documentSnapshot['goalMinute'], style: scorerListPureWhite),
                                Text("' - ", style: scorerListPureWhite),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(documentSnapshot['scorer'], style: scorerListPureWhite),
                              ],
                            ),
                          
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


class scorerAwayList extends StatefulWidget {
 const scorerAwayList({super.key});

  

  @override
  State<scorerAwayList> createState() => scorerAwayListState();
}

class scorerAwayListState extends State<scorerAwayList> {
 


  @override
  Widget build(BuildContext context, ) {

    return Scaffold(
      body: FutureBuilder(
        future: gameData.doc('Event').collection('awayEvent').orderBy('goalMinute').get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return  
                            Container(
                              color: Colors.black,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(documentSnapshot['goalMinute'], style: scorerListPureWhite),
                                  Text("' - ", style: scorerListPureWhite),
                                  Text(documentSnapshot['scorer'], style: scorerListPureWhite),
                                ],
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