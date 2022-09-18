import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:semafor/text_field_decoration.dart';





final CollectionReference clubs =
    FirebaseFirestore.instance.collection('clubs');






class DataOfPlayers{

static String? club;

}

class DropDownClubs extends StatefulWidget {
  @override
  State<DropDownClubs> createState() => DropDownClubsState();
}

class DropDownClubsState extends State<DropDownClubs>{
  static var selectedPlayerClub;
 Future<QuerySnapshot>? firestoreStream;

  @override
  void initState() {
    firestoreStream = clubs.get();
    super.initState();
  }
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
                   future: firestoreStream,
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)  {
                      if (streamSnapshot.hasData) {
                         List<DropdownMenuItem> clubItems = [];
                        for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
                          DocumentSnapshot snapDropDownClubs = streamSnapshot.data!.docs[i];
                          clubItems.add(
                            DropdownMenuItem(
                          
                            
                            value: "${snapDropDownClubs.get('clubName',)}",
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
                                
                                          DataOfPlayers.club=selectedPlayerClub;
                                        });
                                      },
                                      value: selectedPlayerClub,
                                      isExpanded: false,
                                    
                                      
                                      hint: Text(
                                    "Choose Club",
                                   style: settingsTextStyle),
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







