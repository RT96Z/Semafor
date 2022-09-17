import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';



late String clubName;

class clubsDataList extends StatefulWidget {
  const clubsDataList({Key? key}) : super(key: key);

  @override
  _clubsDataListState createState() => _clubsDataListState();
}

class _clubsDataListState extends State<clubsDataList> {
// text fields  controllers

  final TextEditingController _clubIDController = TextEditingController();
  final TextEditingController _ClubNameController = TextEditingController();
  

  final CollectionReference _clubs =
      FirebaseFirestore.instance.collection('clubs');


  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _clubIDController.text = documentSnapshot['clubID'];
      _ClubNameController.text = documentSnapshot['clubName'];
      
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _ClubNameController,
                  decoration: const InputDecoration(labelText: 'ClubName'),
                ),
                TextField(
      
                  controller: _clubIDController,
                  decoration: const InputDecoration(
                    labelText: 'clubID',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = _ClubNameController.text;
                    final String clubID =_clubIDController.text;
                    if (clubID != null) {

                        await _clubs
                            .doc(documentSnapshot!.id)
                            .update({"clubName": name, "clubID": clubID});
                      _ClubNameController.text = '';
                      _clubIDController.text = '';
                        Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _delete(String clubId) async {
    await _clubs.doc(clubId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a club')));
  }

   Future <QuerySnapshot>? firestoreStream;

  @override
  void initState() {
    firestoreStream = _clubs.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder(
        future: firestoreStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(1),
                  child: ListTile(
                    
                    title: Text(documentSnapshot['clubName']),
                    subtitle: Text(documentSnapshot['clubID']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                        IconButton(
                              icon: const Icon(Icons.image_rounded),
                              onPressed: () =>
                                  uploadToStorage(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _update(documentSnapshot)),
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _delete(documentSnapshot.id)),
                        ],
                      ),
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
// Add new club
      
    );
  }


    uploadToStorage([DocumentSnapshot? documentSnapshot]) {

    clubName = documentSnapshot!['clubName'];
    InputElement input = FileUploadInputElement() as InputElement
      ..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref('Clubs').child('$clubName').putBlob(file);
    
       
      });
    });
  }



}