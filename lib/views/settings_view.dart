
import 'package:flutter/material.dart';
import 'package:semafor/components/clubs.dart';
import 'package:semafor/components/drop_down_clubs.dart';
import 'package:semafor/components/players.dart';
import 'package:semafor/components/postave.dart';
import 'package:semafor/components/time.dart';
import 'package:semafor/firebase/reordable_list.dart';
import 'package:semafor/test.dart';
import '../colors.dart';

enum WidgetMarker { Clubs, Players, Postave ,Ostalo }

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SettingsViewBodyWidget();
  }
}

class SettingsViewBodyWidget extends StatefulWidget {
  const SettingsViewBodyWidget({super.key});

  @override
  State<SettingsViewBodyWidget> createState() => _SettingsViewBodyWidgetState();
}

class _SettingsViewBodyWidgetState extends State<SettingsViewBodyWidget> {
  WidgetMarker SelectedWidgetMarker = WidgetMarker.Clubs;

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
                  style: ElevatedButton.styleFrom(backgroundColor: kOpenScoreboardBlue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Back')),
            ),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kOpenScoreboardBlue),
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Clubs;
                    });
                  },
                  child: Text('Clubs'),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kOpenScoreboardBlue),
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Players;
                    });
                  },
                  child: Text('Players'),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kOpenScoreboardBlue),
                  onPressed: () {
                    setState(() {
                      SelectedWidgetMarker = WidgetMarker.Postave;
                    });
                  },
                  child: Text('Postave'),
                )),
            SizedBox(
                width: 100,
                height: 100,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: kOpenScoreboardBlue),
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
      case WidgetMarker.Clubs:
        return ClubsContainer();
      case WidgetMarker.Players:
        return PlayersContainer();
      case WidgetMarker.Postave:
        return PostaveContainer();
      case WidgetMarker.Ostalo:
        return OStaloContainer();
    }
    // return ClubsContainer();  // default container
  }

  Widget ClubsContainer() {
    return Flexible(fit: FlexFit.tight, flex: 1, child: Clubs());
  }

  Widget PlayersContainer() {
    return Flexible(fit: FlexFit.tight, flex: 1, child: Players());
  }
  Widget PostaveContainer() {
    return Flexible(fit: FlexFit.tight, flex: 1, child: Postave());
  }

  Widget OStaloContainer() {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Text('A'),
    // ReorderPlayerHomeLIst()
    );
  }
}
