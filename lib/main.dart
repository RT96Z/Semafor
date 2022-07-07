import 'package:flutter/material.dart';
import 'package:semafor/screens/home_screen.dart';
import 'package:semafor/screens/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Semafor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StartPage(),
      //const HomeScreen(),
    );
  }
}