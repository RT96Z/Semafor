import 'package:flutter/material.dart';
import 'package:semafor/screens/home_screen.dart';
import 'package:semafor/screens/start_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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