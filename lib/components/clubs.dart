import 'package:flutter/material.dart';
import 'package:semafor/text_field_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/firebase/clubsDataBase.dart';

//import 'package:firebase_database/firebase_database.dart';


class Clubs extends StatefulWidget {
  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
 CollectionReference clubData = FirebaseFirestore.instance.collection('clubs');
  //final database = FirebaseDatabase.instance.reference;


  @override
  Widget build(BuildContext context) {

    late String clubNameTextInput;
    late String clubIDTextInput;

 //   final clubTest = database.child('/Klubovi/clubTest'); // Kasnije u verziji promjeniti u npr. Klubovi/ Clubs
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 25,),
              Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  Text('CLUB ID'),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                      width: 500,
                      height: 100,
                      child: TextField(
                        onChanged: (String value) => clubIDTextInput=value,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        decoration: textFieldDecoration,
                      )),
                  
                ],
              ),
              SizedBox(width: 25,),
              Column(
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  Text('CLUB NAME'),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                      width: 500,
                      height: 100,
                      child: TextField(
                        onChanged: (value) => clubNameTextInput=value, // Flutter sam perpoznaje da je string jer samo to i očekuje
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        decoration: textFieldDecoration,
                      )),
                
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  SizedBox(width: 100, height: 60, child: ElevatedButton(onPressed: () async {

                    await clubData.add({'clubID': clubIDTextInput , 'clubName' : clubNameTextInput });

                    // clubTest.set({'id': clubIDTextInput , 'clubName' : clubNameTextInput });


                  }, child: Text('Submit')),),
                  
                  ],
              ),
            ],
          ),

          Row(
              children: [
                Container(
                  
                  height: 500,
                  width: 1400,
                  child: clubsDataList())


              ],)
        ],
      ),
    );





  }
}
