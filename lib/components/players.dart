import 'dart:async';

import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semafor/components/drop_down_clubs.dart';

import 'package:semafor/text_field_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/firebase/playersDataBase.dart';
import 'package:image_picker/image_picker.dart';


class Players extends StatefulWidget {
  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  String uploadedPhotoUrl = '';
Uint8List webImage = Uint8List(8);


// SLIKU IZABIREMO NORMANLO PREKO IMAGE PICKERA
XFile? pickedFile;
chooseImage() async {
pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
// SLIKU PRETVARAMO U Unit8List kako bi je kasnije lakše pokazali prije uploada
      var f = await pickedFile!.readAsBytes();
      setState(() {
        webImage = f;
      });
}



uploadImageToStorage() async {

Reference _reference = FirebaseStorage.instance.ref().child('Players/${dataOfPlayers.club}/${playerNumber.text}');
//Sliku uploadamo u odabranom formatu, u nasem slucaju jpeg formatu.
    await _reference
        .putData(
      await pickedFile!.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    ).whenComplete(() async {
      await _reference.getDownloadURL().then((value) {
        uploadedPhotoUrl = value;
      });
    });

  

}


  CollectionReference playersData =
      FirebaseFirestore.instance.collection('players');

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
                Padding(padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                Column(
                  children: [
                 //   Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('PLAYER NAME'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    SizedBox(
                        width: 350,
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerName,
                        )),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('PLAYER SURNAME'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    SizedBox(
                        width: 350,
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerSurname,
                        )),
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('PLAYER NUMBER'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    SizedBox(
                        width: 350,
                        height: 40,
                        child: TextField(
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerNumber,
                        )),
                   
                    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                    Text('PLAYER CLUB'),
                    Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    SizedBox(
                        width: 350,
                        height: 50,
               
                        child:  DropDownClubs(),)
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child:
                            pickedFile == null
                                  ?  SizedBox(
                                    width: 300,
                                    height: 400,
                                    child: Center(
                                          child: Image.asset(
                                            'assets/pic/defaultPlayer.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                  )
                                    
                                  :  SizedBox(
                                    width: 300,
                                    height: 400,
                                    child:
                                  Center(
                                        child: Image.memory(
                                          webImage,
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                    
                          
                        ),
                        
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                chooseImage();
                              },
                              child: Text('Dodaj Sliku')),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                      showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(milliseconds: 2900), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                       title:   Center(
            child: CircularProgressIndicator(),
          )
                        );
                      });

                                uploadImageToStorage();
                                Timer(Duration(seconds: 3), () {


                       


                                  addUser();
                                  clearPlayerTexts();
                                  setState(() {
                                    pickedFile=null;
                                  });
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Text('Uspjesno dodan igrac'),
                                      );
                                    },
                                  );
                                });
                              },
                              child: Text('Submit')),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(height: 1400, width: 1200, child: playersDataList())
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
    return playersData.add({
      'playerName': playerName.text,
      'playerSurname': playerSurname.text,
      'playerNumber': int.parse(playerNumber.text), //sprema na bazu kao int kako bi se omogućilo sortiranje preko broja igrača
      'playerClub': dataOfPlayers.club,
      'playerPicture': uploadedPhotoUrl,
    });
  }
}
