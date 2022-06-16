import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:semafor/colors.dart';

class MinSec extends StatelessWidget{
  final int currentTimeMinutes;
  final int currentTimeSeconds;
  final int defaultGameclock;
  final bool running;
  final VoidCallback startFunction;
  final VoidCallback stopFunction;
  final VoidCallback resetGameFunction;
  final VoidCallback endHalf;
  final Function setGameFunction;
  final Function setDefaultGameFunction;


  MinSec({
    
    required this.currentTimeMinutes,
    required this.currentTimeSeconds,
    required this.defaultGameclock,
    required this.running,
    required this.startFunction,
    required this.stopFunction,
    required this.resetGameFunction,
    required this.endHalf,
    required this.setGameFunction,
    required this.setDefaultGameFunction
  });

 String _stringTime() {
    Duration duration = Duration();


    String twoDigits(int n) => n.toString().padLeft(
        2, '0'); // pretvara jednoznamenkaste brojeve u "dvoznamenkaste" 9 -> 09
  var currentTimeMinutes = twoDigits(duration.inMinutes.remainder(100));
  var currentTimeSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$currentTimeMinutes:$currentTimeSeconds";
  }

@override
  build(BuildContext context) {
    return Container(
      height: 200,
      width: 580,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Semafor",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              
              child: Text(
                  _stringTime(),
                  style: TextStyle(
                      fontSize: 80,
                      color: kOpenScoreboardBlue,
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white
                      ),
                  onPressed: running ? stopFunction : startFunction,
                  child: running ? Text('Stop') : Text('Start'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: resetGameFunction,

                  child: Text('Reset Game Clock'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: endHalf,

                  child: Text('End of FIRST HALF'),
                ),
              ]
            ),
          ],
        ),
      )
    );
  }

  int _getMinutes(int milliseconds) {
    return (milliseconds ~/ (60 * 1000));
  }

  int _getSeconds (int milliseconds) {
    return (milliseconds - (_getMinutes(milliseconds) * 60 * 1000)) ~/ 1000;
  }

  void _showNumberPicker(
      BuildContext context,
      String display,
      int end,
      int currentMinutes,
      int currentSeconds,
      Function onConfirm) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: end, initValue: currentMinutes),
          NumberPickerColumn(begin: 0, end: 59, initValue: currentSeconds),
        ]),
        backgroundColor: kOpenScoreboardGreyDark,
        containerColor: kOpenScoreboardGreyDark,
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Set "+ display +" Game Clock Value", style: TextStyle(color: kOpenScoreboardBlue)),
        textStyle: TextStyle(color: kOpenScoreboardBlue),
        cancelTextStyle: TextStyle(color: kOpenScoreboardBlue),
        confirmTextStyle: TextStyle(color: kOpenScoreboardBlue),
        // onConfirm: onConfirm
    ).showDialog(context, backgroundColor: kOpenScoreboardGreyDark);
  }




}