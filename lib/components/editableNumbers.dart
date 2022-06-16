import 'package:flutter/material.dart';
import 'package:semafor/colors.dart';

class EditableNumber extends StatelessWidget {
  final String label;
  final String currentNumber;
  final VoidCallback addFunction;
  final VoidCallback removeFunction;
  final VoidCallback resetFunction;

  EditableNumber({
    required this.label,
    required this.currentNumber,
    required this.addFunction,
    required this.removeFunction,
    required this.resetFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   ElevatedButton(
                   style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                          "+",
                          textAlign: TextAlign.center),
                      onPressed: addFunction,

                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                      child: Text(
                          "-",
                          textAlign: TextAlign.center),
                      onPressed: removeFunction,
                    ),
                  ],
                ),
                flex: 3
                ),
              Spacer(flex:1),
              Flexible(
                child: Text(
                  currentNumber.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 55,
                    color: kOpenScoreboardBlue,
                  ),
                ),
                flex: 6,
                )
            ],
          ),
         ElevatedButton(
            style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
            child: Text(
                "Reset",
                textAlign: TextAlign.center),
            onPressed: resetFunction,
          )
        ],
      ),
    );
  }
}
