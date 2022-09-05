import 'dart:async';
import 'package:flutter/material.dart';
import 'package:semafor/text_field_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/firebase/playersDataBase.dart';


class Players extends StatelessWidget {

 CollectionReference playersData = FirebaseFirestore.instance.collection('players');

   final playerName = TextEditingController();
   final playerSurname = TextEditingController();
   final playerNumber = TextEditingController();
   final playerClub = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 25,),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                    Text('PLAYER NAME'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                        width: 500,
                        height: 100,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerName,
                        )),
                    Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                    Text('PLAYER NUMBER'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                        width: 500,
                        height: 100,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerNumber,
                        )),
                  ],
                ),
                SizedBox(width: 25,),
                Column(
                  children: [
                    Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                    Text('PLAYER SURNAME'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                        width: 500,
                        height: 100,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerSurname,
                        )),
                    Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                    Text('PLAYER CLUB'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    SizedBox(
                        width: 500,
                        height: 100,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerClub,
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


        
  
                    

                     }, child: Text('Dodaj')),),

                    Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                     SizedBox(width: 100, height: 60, child: ElevatedButton(onPressed: () async {
                      addUser();
                      clearPlayerTexts();
                      showDialog(
                      context: context,
                       builder: (context) {
                         return AlertDialog(

                      content: Text('Uspjesno dodan igrac'),
                    );
                  },
                );
                    

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
                  child: playersDataList())


              ],


            )
          ],
        ),
      ),


    );
  }

void clearPlayerTexts() {
    // Clean up the controller when the widget is disposed.
    playerName.clear();
    playerSurname.clear();
    playerNumber.clear();
    playerClub.clear();
  }








 Future<void> addUser() {
      // Call the user's CollectionReference to add a new user
      return playersData
          .add({
            'playerName': playerName.text, 
            'playerSurname': playerSurname.text, 
            'playerNumber': playerNumber.text ,
            'playerClub' : playerClub.text
          });
    }

void uploadImage(){


}











}




