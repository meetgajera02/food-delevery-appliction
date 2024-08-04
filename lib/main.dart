import 'package:flutter/material.dart';
import 'package:foody/Screen/Login/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foody/Screen/home.dart';
import 'package:foody/app_provider.dart';
import 'package:foody/firebase_services/firebase_auth.dart';
import 'package:provider/provider.dart'; 
import 'firebase_options.dart';

void main() async {
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
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Foody',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: StreamBuilder(
              stream: FirebaseAuthHelper.instance.getAuthChange,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Home();
                }
                return const Welcome();
              },
            ),
      ),
    );
  }
}
