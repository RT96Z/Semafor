import 'package:flutter/material.dart';
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
      color: Color.fromARGB(255, 9, 52, 87),
      title: 'Semafor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color.fromARGB(255, 9, 52, 87)   // Kasnije dodati da se ovdje mijenja pozadina.
      ),
      home: StartPage(),
      //const HomeScreen(),
    );
  }
} 