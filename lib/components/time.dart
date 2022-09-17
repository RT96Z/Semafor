import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference primamVrijeme =
    FirebaseFirestore.instance.collection('game');

int liveTime = 0, normalTime = 0;
int onPressedTime = 0;
int timeControlls = 0;

class ShowTime extends StatefulWidget {
  const ShowTime({Key? key}) : super(key: key);

  @override
  State<ShowTime> createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {
  Future<int?> getTime() async {
    var a = await primamVrijeme.doc('Time').get();

    setState(() {
      onPressedTime = a['onClick'];
      timeControlls = a['index'];
    });
    return liveTime;
  }

  String _stringTime() {
    liveTime = DateTime.now().millisecondsSinceEpoch - onPressedTime;
    var minutesString =
        _getMinutes(liveTime).remainder(100).toString().padLeft(2, '0');

    var secondsString = _getSeconds(liveTime).toString().padLeft(2, '0');

    return "$minutesString:$secondsString";
  }

 

  @override
  Widget build(BuildContext context) {
    getTime();
    return Scaffold(
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
  
                  Row(
                    children: [
                      IndexedStack(index: timeControlls, children: <Widget>[
                        Container(
                          width: 200,
                          height: 100,
                          color: Colors.black,
                          child: Center(
                            child: Text(
                              '00:00',
                              style: TextStyle(fontSize: 55, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                            width: 200,
                            height: 100,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                _stringTime(),
                                style: TextStyle(
                                    fontSize: 55, color: Colors.white),
                              ),
                            )),
                        Container(
                            width: 200,
                            height: 100,
                            color: Colors.black,
                            child: Center(
                              child: Text(
                                '45:00',
                                style: TextStyle(
                                    fontSize: 55, color: Colors.white),
                              ),
                            )),
                        Container(
                            width: 200,
                            height: 100,
                            color: Colors.transparent,
                            child: Center(
                              child: Text(
                                'KRAJ',
                                style: TextStyle(
                                    fontSize: 35, color: Colors.white),
                              ),
                            )),
                        Text(
                          _stringTime(),
                          style: TextStyle(fontSize: 55, color: Colors.white),
                        )
                      ]),
                    ],
                  ),

            ],
          );
        },
      ),
    );
  }

  int _getMinutes(int milliseconds) {
    return (milliseconds ~/ (60 * 1000));
  }

  int _getSeconds(int milliseconds) {
    return (milliseconds - (_getMinutes(milliseconds) * 60 * 1000)) ~/ 1000;
  }
}
