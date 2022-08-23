import 'package:cloud_firestore/cloud_firestore.dart';

class ClubLIST {
 
  final String id;
  final String clubName;

  ClubLIST({

    required this.id,
    required this.clubName,
  });


/*  SLUŽILO ZA DODAVANJE KLUBA PREKO DRUGOG NAČINA
  Map<String, dynamic> toJson() => {
        'serial': serial,
        'id': id,
        'clubName': clubName,
      };

  */

  static ClubLIST fromJson(Map<String, dynamic> json) =>
      ClubLIST(
        id: json['id'],
         clubName: json['clubName']);
}
