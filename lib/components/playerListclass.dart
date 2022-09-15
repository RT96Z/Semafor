class PlayersList{

int? number;
String? name;
String? surname;
String? playerClub;
String? playerPic;


PlayersList();


Map<String, dynamic> toJson() => {'playerNumber':number ,'playerName' : name, 'playerSurname' : surname, 'playerPicture': playerPic, 'playerClub':playerClub };

PlayersList.fromSnapshot(snapshot)
: number = snapshot.data()['playerNumber'],
  name = snapshot.data()['playerName'],
  surname = snapshot.data()['playerSurname'],
  playerClub = snapshot.data()['playerClub'],
  playerPic = snapshot.data()['playerPicture']

;
}