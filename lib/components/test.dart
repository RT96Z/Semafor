import 'package:flutter/material.dart';

class CustomNavigationBarDemo extends StatefulWidget {


  @override
  _CustomNavigationBarDemoState createState() => _CustomNavigationBarDemoState();
}

class _CustomNavigationBarDemoState extends State<CustomNavigationBarDemo> {

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        child: Column(
          children: <Widget>[
            _stackedContainers(),
            _navigationButtons()
          ],
        ),
        padding: EdgeInsets.all(5.0),
      ),
    );
  }

  Widget _stackedContainers() {
    return Expanded(
      child: IndexedStack(
        index: index,
        children: <Widget>[
          Container(
              child: Center(
                  child: Image.asset("assets/images/flutter.png",)
              )
          ),
          Container(
              child: Center(
                  child: Image.asset("assets/images/powered_by.png",)
              )
          ),
          Container(
              child: Center(
                  child: Image.asset("assets/images/devs.jpg",)
              )
          ),
        ],
      ),
    );
  }

  Widget _navigationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton(
          
          style: ElevatedButton.styleFrom(
                        primary:  Colors.pink[300]
                      ),
          child: Text('Flutter', style: TextStyle(fontSize: 16.0,color: Colors.white),),
          onPressed: () {
            setState(() {
              index = 0;
            });
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
                        primary:  Colors.pink[300]
                      ),
          child: Text('Aeologic', style: TextStyle(fontSize: 16.0,color: Colors.white),),
          onPressed: () {
            setState(() {
              index = 1;
            });
          },
        ),
        ElevatedButton(
           style: ElevatedButton.styleFrom(
                        primary:  Colors.pink[300]
                      ),
          child: Text('Flutter Devs', style: TextStyle(fontSize: 16.0,color: Colors.white),),
          onPressed: () {
            setState(() {
              index = 2;
            });
          },
        ),
      ],
    );
  }
}