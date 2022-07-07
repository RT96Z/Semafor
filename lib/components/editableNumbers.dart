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
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   ElevatedButton(
                   style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                      onPressed: addFunction,
                      child: const Text(
                          "+",
                          textAlign: TextAlign.center),

                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
                      onPressed: removeFunction,
                      child: const Text(
                          "-",
                          textAlign: TextAlign.center),
                    ),
                  ],
                )
                ),
              const Spacer(flex:1),
              Flexible(
                flex: 6,
                child: Text(
                  currentNumber.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontSize: 55,
                    color: kOpenScoreboardBlue,
                  ),
                ),
                )
            ],
          ),
         ElevatedButton(
            style: ElevatedButton.styleFrom(
                        primary:  kOpenScoreboardGreyDarker,
                        onPrimary: Colors.white,
                      ),
            onPressed: resetFunction,
            child: const Text(
                "Reset",
                textAlign: TextAlign.center),
          )
        ],
      ),
    );
  }
}
