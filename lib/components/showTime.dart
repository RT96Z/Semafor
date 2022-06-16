import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:semafor/colors.dart';

class GameClockView1 extends StatelessWidget{
    final int currentTimeMilliseconds;
  final int defaultGameclock;
  final bool running;


  GameClockView1({
    required this.currentTimeMilliseconds,
    required this.defaultGameclock,
    required this.running,
  });

 String _stringTime() {
    var minutesString = _getMinutes(currentTimeMilliseconds).toString().padLeft(2, '0');

    var secondsString = _getSeconds(currentTimeMilliseconds).toString().padLeft(2, '0');

    return "$minutesString:$secondsString";
  }

@override
  build(BuildContext context) {
    return Container(
      height: 200,
      width: 110,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,


      ),
       alignment: Alignment.topCenter,
      child: Center(
        child: Column(
        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            
            GestureDetector(
              child: Text(
                  _stringTime(),
                  style: TextStyle(
                      fontSize: 30,
                      color: kOpenScoreboardBlue,
                  ),
              ),
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