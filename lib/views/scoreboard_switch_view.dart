
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:semafor/components/video.dart';
import 'package:semafor/screens/prikaz_zamjena.dart';


import 'package:semafor/views/publicScoreboardScreen.dart';

final CollectionReference gameData =
    FirebaseFirestore.instance.collection('game');





class ScoreboardSwitch extends StatefulWidget {



  @override
  State<ScoreboardSwitch> createState() => _ScoreboardSwitchState();
}

class _ScoreboardSwitchState extends State<ScoreboardSwitch> {

  int? switchero;

  Future<int?> getIndex() async {
    var b = await gameData.doc('Event').collection('Events').doc('Video').get();
    setState(() {
      switchero = b['videoIndex'];
    });
    return switchero;
  }



  @override
  Widget build(BuildContext context) {
    getIndex();
    return Container(

          child: getCustomContainer(),
        );

  }

  Widget? getCustomContainer() {
    switch (switchero) {
      case 0:
        return semaforPrikaz();
      case 1:
        return videoPrikaz();

      case 2:
        return ZamjenePrikaz();
 

    }
    // return semaforPrikaz();  // default container
  }

  Widget semaforPrikaz() {
    return Flexible(fit: FlexFit.tight, flex: 1, child: PublicScoreboardScreen());
  }

  Widget videoPrikaz() {
    return Container( height: 200, width: 200, child: VideoScreen());
  }

  Widget ZamjenePrikaz() {
    return Container( height: 800, width: 900, child: ShowReplacements());
  }

}
