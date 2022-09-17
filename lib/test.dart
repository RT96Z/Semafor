// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:flutter/material.dart';

// final CollectionReference showFromBase =
//     FirebaseFirestore.instance.collection('game');

// class ShowReplacements extends StatefulWidget {
//   const ShowReplacements({super.key});

//   @override
//   State<ShowReplacements> createState() => _ShowReplacementsState();
// }

// class _ShowReplacementsState extends State<ShowReplacements> {
//   String? playerOUTName,
//       playerOUTSurname,
//       playerOUTNumber,
//       playerOUTPicture,
//       playerINName,
//       playerINSurname,
//       playerINNumber,
//       playerINPicture;

//   Future<String?> getPlayerData() async {
//     var a = await showFromBase
//         .doc('Event')
//         .collection('Events')
//         .doc('ShowPlayer')
//         .get();
//     var b = await showFromBase
//         .doc('Event')
//         .collection('Events')
//         .doc('PlayerIN')
//         .get();

//     setState(() {
//       playerOUTName = a['playerName'];
//       playerOUTSurname = a['playerSurname'];
//       playerOUTNumber = a['playerNumber'].toString();
//       playerOUTPicture = a['playerPicture'];

//       playerINName = b['playerName'];
//       playerINSurname = b['playerSurname'];
//       playerINNumber = b['playerNumber'].toString();
//       playerINPicture = b['playerPicture'];
//     });
//     return playerOUTName;
//   }

//   @override
//   Widget build(BuildContext context) {
//     getPlayerData();
//     return Container(
//       height: 700,
//       width: 900,
//       child:


//         Table(
//           children: [
//             TableRow(children: [
// SizedBox( height: 50,), SizedBox( height: 20,),SizedBox( height: 20,),SizedBox( height: 20,),SizedBox( height: 20,),SizedBox( height: 20,),SizedBox( height: 20,),
//             ]),
//             TableRow(
//               children: [
//                 SizedBox( height: 20,width: 50,),
//                 TableCell(
//                   child: SizedBox(
//                   width: 350,
//                   height: 350,
//                   child: playerOUTPicture != null
//                       ? Image.network('$playerOUTPicture}', fit: BoxFit.cover)
//                       :
//                       // Image.asset('assets/pic/defaultPlayer.png', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
//                       Text(''),
//                 ),),
//                 TableCell(child: SizedBox(
//                   width: 100,
//                   height: 150,
//                   child: Text(
//                     playerOUTNumber.toString(),
//                     style: TextStyle(fontSize: 80, color: Colors.white),
//                   ),
//                 ) ),
//                 TableCell(child: SizedBox(
//                   width: 200,
//                   height: 200,
//                   child: 
//                        Image.asset('assets/pic/subGif.gif', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
                     
//                 ),),
//                 TableCell(child:  SizedBox(
//                   width: 100,
//                   height: 150,
//                   child: Text(
//                     playerINNumber.toString(),
//                     style: TextStyle(fontSize: 80, color: Colors.white),
//                   ),
//                 ),),
//                 TableCell(child: SizedBox(
//                   width: 350,
//                   height: 350,
//                   child: playerINPicture != null
//                       ? Image.network('$playerINPicture}', fit: BoxFit.cover)
//                       :
//                       // Image.asset('assets/pic/defaultPlayer.png', fit: BoxFit.cover,),  //moze i ovako ali to bolje staviti za igrace koji nemaju uopce sliku
//                       Text(''),
//                 ),),
//                 SizedBox( height: 20,width: 50,),
//               ]
//             )
//           ],
//         )
      
//     );
//   }
// }
