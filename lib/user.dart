import 'package:cloud_firestore/cloud_firestore.dart';

class homeClub {
 
  final String clubName;
  int goals;

  homeClub({

     this.goals = 0,
    required this.clubName,
  });



}



class awayClub {
 
  final String clubName;
  int goals;

  awayClub({

     this.goals = 0,
    required this.clubName,
  });







}

class AustinFeedsMeEvent {
  static final String columnId = "_id";
  static final String columnName = "name";


  AustinFeedsMeEvent({
    required this.name

  
  });

  final String name;

 

  Map toMap() {
    Map<String, dynamic> map = {
      columnName: name,

 
    };

    return map;
  }

  static AustinFeedsMeEvent fromMap(Map map) {
    return new AustinFeedsMeEvent(
        name: map[columnName]);


  }
}
