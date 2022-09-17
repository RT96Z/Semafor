import 'package:flutter/material.dart';
import 'package:semafor/views/home_view.dart';
import 'package:semafor/views/scoreboard_switch_view.dart';


import 'package:semafor/views/settings_view.dart';


class StartPage extends StatefulWidget {
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              width: 800,
              height: 100,
              child: ElevatedButton(
                onPressed: (() {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => ScoreboardSwitch() ));
                }),
                child: Text(
                  "Prikaz semafora",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
              height: 30,
            ),
            SizedBox(
              width: 800,
              height: 100,
              child: ElevatedButton(
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeView();
                    }));
                  }),
                  child: Text('Upravljanje semaforom',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 800,
              height: 100,
              child: ElevatedButton(
                  onPressed: (() {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SettingsView();
                    }));
                  }),
                  child: Text('Unos podataka',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))),
            ),
            SizedBox(
              height: 30,
            ),
        
            
          ])),
    );
  }
}
