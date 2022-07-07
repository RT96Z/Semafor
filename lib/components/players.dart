import 'package:flutter/material.dart';
import 'package:semafor/text_field_decoration.dart';

class Players extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(width: 25,),
          Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Text('PLAYER NAME'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(
                  width: 500,
                  height: 100,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    decoration: textFieldDecoration,
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Text('PLAYER NUMBER'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(
                  width: 500,
                  height: 100,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    decoration: textFieldDecoration,
                  )),
            ],
          ),
          SizedBox(width: 25,),
          Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Text('PLAYER SURNAME'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(
                  width: 500,
                  height: 100,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    decoration: textFieldDecoration,
                  )),
              Padding(padding: EdgeInsets.symmetric(vertical: 30)),
              Text('PLAYER POSITION'),
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              SizedBox(
                  width: 500,
                  height: 100,
                  child: TextField(
                    style: TextStyle(
                      color: Colors.red,
                    ),
                    decoration: textFieldDecoration,
                  )),
            ],
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 45)),
               SizedBox(width: 100, height: 60, child: ElevatedButton(onPressed: () {}, child: Text('Submit')),),
            ],
          ),
        ],
      ),
    );
  }
}
