import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';





final CollectionReference clubs =
    FirebaseFirestore.instance.collection('clubs');



final CollectionReference clubData = FirebaseFirestore.instance.collection('game');


class dataOfPlayers{

static String? club;

}

class DropDownClubs extends StatefulWidget {
  @override
  State<DropDownClubs> createState() => DropDownClubsState();
}

class DropDownClubsState extends State<DropDownClubs>{
  static var selectedPlayerClub;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
  
              children: [
                FutureBuilder<QuerySnapshot>(
                   future: clubs.get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
                      if (streamSnapshot.hasData) {
                         List<DropdownMenuItem> clubItems = [];
                        for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                          DocumentSnapshot snapDropDownClubs = streamSnapshot.data!.docs[i];
                          clubItems.add(
                            DropdownMenuItem(
                            
                        
                            value: "${snapDropDownClubs.get('clubName')}",
                            child: Expanded(
                              
                              child: Text(
                                snapDropDownClubs.get('clubName'),
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ));
                        }
                        return 

                            Row(
                              children: [
                                 DropdownButton(
                                    
                                      items: clubItems,
                                      onChanged: (clubValues) {
                                        setState(() {
                                          selectedPlayerClub = clubValues;
                                
                                          dataOfPlayers.club=selectedPlayerClub;
                                        });
                                      },
                                      value: selectedPlayerClub,
                                      isExpanded: false,
                                    
                                      
                                      hint: Text(
                                    "Choose Club",
                                    style: TextStyle(color: Colors.black)),
                                      ),
                              
                              ],
                            );
                      
                      } 

                      return const Center(
                      child: CircularProgressIndicator(),
          );
                    }),
              
          
              ],
            ),
          
          ],
        ),
   
    );
  }




}






