
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class clubsDataList extends StatefulWidget {
  const clubsDataList({Key? key}) : super(key: key);

  @override
  _clubsDataListState createState() => _clubsDataListState();
}

class _clubsDataListState extends State<clubsDataList> {
// text fields' controllers

  final TextEditingController _clubIDController = TextEditingController();
  final TextEditingController _ClubNameController = TextEditingController();
  

  final CollectionReference _products =
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
                    final double? clubID =
                        double.tryParse(_clubIDController.text);
                    if (clubID != null) {

                        await _products
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

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: StreamBuilder(
        stream: _products.snapshots(),
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
// Add new product
      
    );
  }
}