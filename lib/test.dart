import 'dart:async';

import 'package:flutter/material.dart';
import 'package:semafor/firebase/scorer_list.dart';

class Time extends StatefulWidget {
  @override
  State<Time> createState() => TimeState();
}

class TimeState extends State<Time> {
  Duration duration = Duration();
  Timer? timer;

  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    reset();
  }

  void reset() {
    setState(() => duration = Duration());
  }

  void addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void startTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      reset();
    }

    setState(() {
      timer?.cancel();
    });
  }

  void firstHalfEnd() {
    setState(() => duration = Duration(minutes: 45, seconds: 00));
    stopTimer(resets: false);
  }

  void secondHalfEnd() {
    setState(() => duration = Duration(minutes: 90, seconds: 00));
    stopTimer(resets: false);
  }

  void addMinute() {
    setState(() {
      duration = duration + Duration(minutes: 1);
    });
  }

  void subtractMinute() {
    setState(() {
      duration = duration - Duration(minutes: 1);
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.green,
        body:
           Row(
                            children: [
                              Container(
                                height: 400,
                                width: 200,
                                child: scorerHomeList(),
                              ),
                            SizedBox(width: 20,),
                            Container(
                                height: 400,
                                width: 200,
                                child: scorerAwayList(),
                              )
                            ],
                          )

          
     
      
      );

  Widget buiildTime() {
    String twoDigits(int n) => n.toString().padLeft(
        2, '0'); // pretvara jednoznamenkaste brojeve u "dvoznamenkaste" 9 -> 09
    final minutes = twoDigits(duration.inMinutes.remainder(100));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    setState(() {
      // time.doc('Time').collection('minutes').doc('minutes').set({'minutes': '$minutes'});
      // time.doc('Time').update({'seconds': '$seconds'});
    });
    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 20),
    );
  }

  Widget buildButtons() {
    bool time_going = timer == null ? false : timer!.isActive;
    bool time_stops = duration.inSeconds == 0;

    return time_going || !time_stops
        ? Column( 
          

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text(time_going ? 'PAUSE' : 'RESUME'),
                      onPressed: () {
                        if (time_going) {
                          stopTimer(resets: false);
                        } else {
                          startTimer(resets: false);
                        }
                      }),
                  SizedBox(
                    width: 12,
                  ),
                  ElevatedButton(
                    child: Text("RESET"),
                    onPressed: reset,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: firstHalfEnd,
                    child: Text('1. Half END'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      child: TextButton(
                    onPressed: secondHalfEnd,
                    child: Text('2. Half END'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  )),
                ],
              ),
              Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: addMinute, child: Text('+1 minute')),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: subtractMinute, child: Text('-1 minute'))
                ],
              )
            ],
          )
        : TextButton(
            onPressed: startTimer,
            child: Text('Start Timer!'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ));
  }
}