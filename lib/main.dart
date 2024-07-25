import 'package:flutter/material.dart';
import 'package:foody/Login/welcome.dart';
import 'package:firebase_core/firebase_core.dart'; 
import 'firebase_options.dart';

Future main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
 options: DefaultFirebaseOptions.currentPlatform,
 );
 runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foody',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}
