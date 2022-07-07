import 'dart:html';

import 'package:flutter/material.dart';
import 'package:semafor/components/clubs.dart';

import '../colors.dart';


enum WidgetMarker { Golovi, Reklame, Ostalo }

class Switcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwitcherBodyWidget();
  }
}

class SwitcherBodyWidget extends StatefulWidget {
  const SwitcherBodyWidget({super.key});

  @override
  State<SwitcherBodyWidget> createState() => _SwitcherBodyWidgetState();
}

class _SwitcherBodyWidgetState extends State<SwitcherBodyWidget> {
  WidgetMarker SelectedWidgetMarker = WidgetMarker.Golovi;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Golovi;
                    });
                  },
                  child: Text('Golovi'),
                )),

            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kOpenScoreboardBlue
                  ),
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Reklame;
                    });
                  },
                  child: Text('Reklame'),
                )),

            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Ostalo;
                    });
                  },
                  child: Text('Ostalo'),
                )),
          ],
        ),
        Container(
          child: getCustomContainer(),
        ),
      ],
    );
  }

  Widget getCustomContainer() {
    switch (SelectedWidgetMarker) {
      case WidgetMarker.Golovi:
        return GoloviContainer();
      case WidgetMarker.Reklame:
        return ReklameContainer();
      case WidgetMarker.Ostalo:
        return OStaloContainer();
    }
    return GoloviContainer();
  }

  Widget GoloviContainer() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        height: 300,
        color: Colors.red,
      ),
    );
  }

  Widget ReklameContainer() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        height: 300,
        color: Colors.blue,
      ),
    );
  }

  Widget OStaloContainer() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Container(
        height: 300,
        color: Colors.blueGrey,
      ),
    );
  }
}
