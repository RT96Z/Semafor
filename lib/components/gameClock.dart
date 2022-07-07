import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:semafor/colors.dart';

class GameClockView extends StatelessWidget{
    final int currentTimeMilliseconds;
  final int defaultGameclock;
  final bool running;
  final VoidCallback startFunction;
  final VoidCallback stopFunction;
  final VoidCallback resetGameFunction;
  final VoidCallback endHalf;
  final VoidCallback fullTime;
  final Function setGameFunction;
  final Function setDefaultGameFunction;


  GameClockView({
    
    required this.currentTimeMilliseconds,
    required this.defaultGameclock,
    required this.running,
    required this.startFunction,
    required this.stopFunction,
    required this.resetGameFunction,
    required this.endHalf,
    required this.fullTime,
    required this.setGameFunction,
    required this.setDefaultGameFunction
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
      width: 580,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Text(
              "Scoreboard",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onLongPress: () {
                _showNumberPicker(
                    context,
                    "Current",
                    (defaultGameclock ~/ (60 * 1000)),
                    _getMinutes(currentTimeMilliseconds),
                    _getSeconds(currentTimeMilliseconds),
                    (Picker picker, List value) {
                      setGameFunction((value[0] * 60 * 1000) + value[1] * 1000);
                    });
              },
              child: Text(
                  _stringTime(),
                  style: const TextStyle(
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
                  child: running ? const Text('Stop') : const Text('Start'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: resetGameFunction,

                  child: const Text('Reset Game Clock'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: endHalf,

                  child: const Text('End of FIRST HALF'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                  onPressed: fullTime,

                  child: const Text('End of SECOND HALF'),
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
    Picker(
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
            child: const Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: Text("Set "+ display +" Game Clock Value", style: const TextStyle(color: kOpenScoreboardBlue)),
        textStyle: const TextStyle(color: kOpenScoreboardBlue),
        cancelTextStyle: const TextStyle(color: kOpenScoreboardBlue),
        confirmTextStyle: const TextStyle(color: kOpenScoreboardBlue),
        // onConfirm: onConfirm
    ).showDialog(context, backgroundColor: kOpenScoreboardGreyDark);
  }




}