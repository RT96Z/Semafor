import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:semafor/text_field_decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semafor/firebase/clubsDataBase.dart';


late String clubNameTextInput;
late String clubIDTextInput;

final storg = FirebaseStorage.instance;
String? imgUrl;

class Clubs extends StatefulWidget {
  const Clubs({super.key});

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {
  CollectionReference clubData = FirebaseFirestore.instance.collection('clubs');

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  const Text('CLUB ID'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                      width: 500,
                      height: 100,
                      child: TextField(
                        onChanged: (String value) => clubIDTextInput = value,
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                        decoration: textFieldDecoration,
                      )),
                ],
              ),
              const SizedBox(
                width: 25,
              ),
              Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
                  const Text('CLUB NAME'),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  SizedBox(
                      width: 500,
                      height: 100,
                      child: TextField(
                        onChanged: (value) => clubNameTextInput =
                            value, // Flutter sam perpoznaje da je string jer samo to i očekuje
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                        decoration: textFieldDecoration,
                      )),
                ],
              ),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 20)),

                  SizedBox(
                    width: 100,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          await clubData.add({
                            'clubID': clubIDTextInput,
                            'clubName': clubNameTextInput,
                          });

                         
                        },
                        child: const Text('Submit')),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              SizedBox(height: 500, width: 1200, child: clubsDataList())
            ],
          )
        ],
      )),
    );
  }


  


}
