import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:semafor/colors.dart';

class MinuteSekunde extends StatelessWidget{

    final int currentTimeMinutes;
    final int currentTimeSeconds;
  final int defaultGameclock;
  final bool running;


  MinuteSekunde({

    required this.currentTimeMinutes,
    required this.currentTimeSeconds,
    required this.defaultGameclock,
    required this.running,
  });

 String _stringTime() {
   
    Duration duration = Duration();


    String twoDigits(int n) => n.toString().padLeft(
        2, '0'); // pretvara jednoznamenkaste brojeve u "dvoznamenkaste" 9 -> 09
   var currentTimeMinutes = twoDigits(duration.inMinutes.remainder(100));
    final currentTimeSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$currentTimeMinutes:$currentTimeSeconds";
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