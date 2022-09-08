import 'dart:async';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:semafor/firebase/game_list.dart';
import 'package:semafor/text_field_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/firebase/playersDataBase.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class Players extends StatefulWidget {
  @override
  State<Players> createState() => _PlayersState();
}

class _PlayersState extends State<Players> {
  String uploadedPhotoUrl = '';
  Uint8List webImage = Uint8List(8);
  XFile? image;

  Future<void> IMGP() async {
    final ImagePicker picker = ImagePicker();
   image = await picker.pickImage(source: ImageSource.gallery);
    if (picker != null) {
      var f = await image!.readAsBytes();
      setState(() {
        webImage = f;
      });
    }
  }

  Future<String> IMGU() async {
    var uploadTask = FirebaseStorage.instance
        .ref()
        .child('Players/${playerClub.text}/${playerNumber.text}');

    var AAA = await uploadTask.putData(webImage);

    var downloadURL = await (await AAA).ref.getDownloadURL();

    uploadedPhotoUrl = downloadURL;

    return downloadURL;
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
                        height: 40,
                        child: TextField(
                          style: TextStyle(
                            color: Colors.red,
                          ),
                          decoration: textFieldDecoration,
                          controller: playerClub,
                        )),
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
                            image == null
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
                                IMGP();
                              },
                              child: Text('Dodaj Sliku')),
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                        SizedBox(
                          width: 100,
                          height: 60,
                          child: ElevatedButton(
                              onPressed: () {
                                IMGU();
                                Timer(Duration(seconds: 3), () {
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
                                });
                              },
                              child: Text('Submit')),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [],
                ),
                Column(
                  children: [],
                )
              ],
            ),
            Row(
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
      'playerNumber': playerNumber.text,
      'playerClub': playerClub.text,
      'playerPicture': uploadedPhotoUrl,
    });
  }
}
